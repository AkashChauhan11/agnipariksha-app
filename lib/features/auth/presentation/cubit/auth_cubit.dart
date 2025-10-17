import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  // Register user
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) => emit(RegistrationSuccess(
        email: email,
        message: data['message'] as String,
      )),
    );
  }

  // Login user
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.login(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) {
        // Check if response indicates unverified user
        if (data['isVerified'] == false) {
          emit(LoginUnverified(
            email: email,
            message: data['message'] as String? ?? 'Please verify your email',
          ));
        } else if (data['accessToken'] != null && data['user'] != null) {
          // User is verified, emit success
          final userMap = data['user'] as Map<String, dynamic>;
          final user = _mapToUser(userMap);
          emit(LoginSuccess(
            user: user,
            accessToken: data['accessToken'] as String,
          ));
        } else {
          emit(AuthError(message: 'Unexpected response from server'));
        }
      },
    );
  }

  // Verify OTP
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoading());

    final result = await authRepository.verifyOtp(
      email: email,
      otp: otp,
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) {
        if (data['accessToken'] != null && data['user'] != null) {
          final userMap = data['user'] as Map<String, dynamic>;
          final user = _mapToUser(userMap);
          emit(OtpVerificationSuccess(
            user: user,
            accessToken: data['accessToken'] as String,
          ));
        }
      },
    );
  }

  // Resend OTP
  Future<void> resendOtp({required String email}) async {
    emit(AuthLoading());

    final result = await authRepository.resendOtp(email: email);

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) => emit(OtpResendSuccess(
        message: data['message'] as String,
      )),
    );
  }

  // Check authentication status
  Future<void> checkAuthStatus() async {
    final result = await authRepository.getCurrentUser();

    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) => emit(Authenticated(user: user)),
    );
  }

  // Logout
  Future<void> logout() async {
    emit(AuthLoading());

    final result = await authRepository.logout();

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }

  // Helper method to map user data
  User _mapToUser(Map<String, dynamic> userMap) {
    return User(
      id: userMap['id'] as String,
      email: userMap['email'] as String,
      firstName: userMap['firstName'] as String,
      lastName: userMap['lastName'] as String,
      phone: userMap['phone'] as String?,
      role: userMap['role'] as String,
      isActive: userMap['isActive'] as bool? ?? true,
      isVerified: userMap['isVerified'] as bool? ?? false,
    );
  }
}

