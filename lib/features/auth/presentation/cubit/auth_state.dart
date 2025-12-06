import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AuthInitial extends AuthState {}

// Loading states
class AuthLoading extends AuthState {}

// Registration states
class RegistrationSuccess extends AuthState {
  final String email;
  final String message;

  const RegistrationSuccess({
    required this.email,
    required this.message,
  });

  @override
  List<Object?> get props => [email, message];
}

// Login states
class LoginSuccess extends AuthState {
  final User user;
  final String accessToken;

  const LoginSuccess({
    required this.user,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [user, accessToken];
}

class LoginUnverified extends AuthState {
  final String email;
  final String message;

  const LoginUnverified({
    required this.email,
    required this.message,
  });

  @override
  List<Object?> get props => [email, message];
}

// OTP verification states
class OtpVerificationSuccess extends AuthState {
  final User user;
 

  const OtpVerificationSuccess({
    required this.user,
  
  });

  @override
  List<Object?> get props => [user];
}

// OTP resend states
class OtpResendSuccess extends AuthState {
  final String message;

  const OtpResendSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// Forgot password states
class ForgotPasswordSuccess extends AuthState {
  final String email;
  final String message;

  const ForgotPasswordSuccess({
    required this.email,
    required this.message,
  });

  @override
  List<Object?> get props => [email, message];
}

// Reset password states
class ResetPasswordSuccess extends AuthState {
  final String message;

  const ResetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// Authenticated state
class Authenticated extends AuthState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

// Unauthenticated state
class Unauthenticated extends AuthState {}

// Error state
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Logout state
class LogoutSuccess extends AuthState {}

