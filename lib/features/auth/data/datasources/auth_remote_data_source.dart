import 'dart:convert';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/storage_service.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  });

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Map<String, dynamic>> resendOtp({
    required String email,
  });

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  });

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });

  Future<UserModel> getCurrentUser();
  
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  final StorageService storageService;

  AuthRemoteDataSourceImpl({
    required this.apiService,
    required this.storageService,
  });

  @override
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.register,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          if (phone != null && phone.isNotEmpty) 'phone': phone,
        },
      );

      // Extract data from nested response structure
      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as Map<String, dynamic>;
      
      // Add message from response root if available
      if (responseData['message'] != null) {
        data['message'] = responseData['message'];
      }
      
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      // Extract data from nested response structure
      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as Map<String, dynamic>;
      
      // If login is successful and user is verified, save token
      if (data['accessToken'] != null) {
        await storageService.saveAccessToken(data['accessToken']);
        await storageService.setLoggedIn(true);
        
        if (data['user'] != null) {
          await storageService.saveUserData(jsonEncode(data['user']));
        }
      }

      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.verifyOtp,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      // Extract data from nested response structure
      final responseData = response.data as Map<String, dynamic>;
      final data = responseData['data'] as Map<String, dynamic>;
      
      // Save token and user data after successful verification
      if (data['accessToken'] != null) {
        await storageService.saveAccessToken(data['accessToken']);
        await storageService.setLoggedIn(true);
        
        if (data['user'] != null) {
          await storageService.saveUserData(jsonEncode(data['user']));
        }
      }

      // Add message from response root if available
      if (responseData['message'] != null) {
        data['message'] = responseData['message'];
      }

      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.resendOtp,
        data: {
          'email': email,
        },
      );

      // Extract data from nested response structure
      final responseData = response.data as Map<String, dynamic>;
      
      // For resend OTP, the message might be at root level
      return {
        'message': responseData['message'] ?? 'OTP has been resent',
        if (responseData['data'] != null) ...responseData['data'] as Map<String, dynamic>,
      };
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final userData = await storageService.getUserData();
      
      if (userData == null) {
        throw CacheException('No user data found');
      }

      final userJson = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(userJson);
    } catch (e) {
      throw CacheException('Failed to get user data');
    }
  }

  @override
  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.forgotPassword,
        data: {
          'email': email,
        },
      );

      // Extract data from nested response structure
      final responseData = response.data as Map<String, dynamic>;
      
      // For forgot password, the message might be at root level
      return {
        'message': responseData['message'] ?? 'Password reset OTP has been sent to your email',
        if (responseData['data'] != null) ...responseData['data'] as Map<String, dynamic>,
      };
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.resetPassword,
        data: {
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        },
      );

      // Extract data from nested response structure
      final responseData = response.data as Map<String, dynamic>;
      
      return {
        'message': responseData['message'] ?? 'Password has been reset successfully',
        if (responseData['data'] != null) ...responseData['data'] as Map<String, dynamic>,
      };
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await storageService.clearAll();
    } catch (e) {
      throw CacheException('Failed to logout');
    }
  }
}

