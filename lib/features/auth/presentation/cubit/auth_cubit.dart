import 'package:agni_pariksha/features/auth/domain/usecase/register.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/login.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/verify_otp.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/resend_otp.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/forgot_password.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/verify_reset_otp.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/reset_password.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/get_current_user.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/validate_session.dart';
import 'package:agni_pariksha/features/auth/domain/usecase/logout.dart';
import 'package:agni_pariksha/core/services/storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUsecase registerUsecase;
  final LoginUsecase loginUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final ResendOtpUsecase resendOtpUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;
  final VerifyResetOtpUsecase verifyResetOtpUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final ValidateSessionUsecase validateSessionUsecase;
  final LogoutUsecase logoutUsecase;
  final StorageService storageService;

  AuthCubit({
    required this.registerUsecase,
    required this.loginUsecase,
    required this.verifyOtpUsecase,
    required this.resendOtpUsecase,
    required this.forgotPasswordUsecase,
    required this.verifyResetOtpUsecase,
    required this.resetPasswordUsecase,
    required this.getCurrentUserUsecase,
    required this.validateSessionUsecase,
    required this.logoutUsecase,
    required this.storageService,
  }) : super(AuthInitial());

  // Register user
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,

    String? phone,
    String? state,
    String? city,
  }) async {
    emit(AuthLoading());

    final result = await registerUsecase(
      RegisterParams(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        state: state,
        city: city,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) => emit(
        RegistrationSuccess(email: email, message: data['message'] as String),
      ),
    );
  }

  // Login user
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    final result = await loginUsecase(
      LoginParams(email: email, password: password),
    );

    result.fold((failure) => emit(AuthError(message: failure.message)), (data) {
      // Check if response indicates unverified user
      if (data['isVerified'] == false) {
        emit(
          LoginUnverified(
            email: email,
            message: data['message'] as String? ?? 'Please verify your email',
          ),
        );
      } else if (data['accessToken'] != null && data['user'] != null) {
        // User is verified, emit success
        final userMap = data['user'] as Map<String, dynamic>;
        final user = User(
          id: userMap['id'] as String,
          code: userMap['userCode'] as String,
          email: email,
          firstName: userMap['firstName'] as String,
          lastName: userMap['lastName'] as String,
          role: userMap['role'] as String,
          phone: userMap['phone'] as String,
          isActive: userMap['isActive'] as bool,
          isVerified: userMap['isVerified'] as bool,
        );

        emit(
          LoginSuccess(user: user, accessToken: data['accessToken'] as String),
        );
        emit(Authenticated(user: user));
      } else {
        emit(AuthError(message: 'Unexpected response from server'));
      }
    });
  }

  // Verify OTP
  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(AuthLoading());

    final result = await verifyOtpUsecase(
      VerifyOtpParams(email: email, otp: otp),
    );

    result.fold((failure) => emit(AuthError(message: failure.message)), (data) {
      if (data['accessToken'] != null && data['user'] != null) {
        final userMap = data['user'] as Map<String, dynamic>;
        final user = User(
          id: userMap['id'] as String,
          code: userMap['userCode'] as String,
          email: email,
          firstName: userMap['firstName'] as String,
          lastName: userMap['lastName'] as String,
          role: userMap['role'] as String,
          isActive: userMap['isActive'] as bool,
          isVerified: userMap['isVerified'] as bool,
        );
        _clearSession(); // Ensure no stale session exists so user must login manually
        emit(OtpVerificationSuccess(user: user));
      }
    });
  }

  // Resend OTP
  Future<void> resendOtp({required String email}) async {
    emit(AuthLoading());

    final result = await resendOtpUsecase(ResendOtpParams(email: email));

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) => emit(OtpResendSuccess(message: data['message'] as String)),
    );
  }

  // Forgot password
  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());

    final result = await forgotPasswordUsecase(
      ForgotPasswordParams(email: email),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) => emit(
        ForgotPasswordSuccess(email: email, message: data['message'] as String),
      ),
    );
  }

  // Verify reset password OTP
  Future<void> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoading());

    final result = await verifyResetOtpUsecase(
      VerifyResetOtpParams(email: email, otp: otp),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) =>
          emit(ResetOtpVerificationSuccess(message: data['message'] as String)),
    );
  }

  // Reset password
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(AuthLoading());

    final result = await resetPasswordUsecase(
      ResetPasswordParams(email: email, newPassword: newPassword),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (data) => emit(ResetPasswordSuccess(message: data['message'] as String)),
    );
  }

  // Check authentication status - validates token with backend
  Future<void> checkAuthStatus() async {
    // First check if we have token and login flag
    final isLoggedIn = await storageService.isLoggedIn();
    final accessToken = await storageService.getAccessToken();

    if (!isLoggedIn || accessToken == null || accessToken.isEmpty) {
      emit(Unauthenticated());
      return;
    }

    // Validate token with backend
    emit(AuthLoading());

    final result = await validateSessionUsecase();

    result.fold(
      (failure) {
        // Token is invalid or expired, clear session
        _clearSession();
        emit(Unauthenticated());
      },
      (user) {
        // Token is valid, user is authenticated
        emit(Authenticated(user: user));
      },
    );
  }

  // Clear session helper
  void _clearSession() {
    storageService.clearAll();
  }

  // Logout
  Future<void> logout() async {
    emit(AuthLoading());

    final result = await logoutUsecase();

    result.fold(
      (failure) {
        // Even if logout fails, clear local session
        _clearSession();
        emit(LogoutSuccess());
      },
      (_) {
        _clearSession();
        emit(LogoutSuccess());
      },
    );
  }
}
