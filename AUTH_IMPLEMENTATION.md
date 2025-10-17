# Authentication Implementation Guide

## 🎉 Overview

This document describes the complete authentication system implementation for the Agni Pariksha Flutter app, featuring email-based OTP authentication with a clean architecture following industry standards.

## 🏗️ Architecture

The authentication system follows a **Clean Architecture** pattern with clear separation of concerns:

```
lib/
├── core/
│   ├── constants/
│   │   └── api_constants.dart          # API endpoints & constants
│   ├── errors/
│   │   ├── failures.dart               # Failure classes
│   │   └── exceptions.dart             # Exception classes
│   ├── routes/
│   │   ├── app_router.dart             # GoRouter configuration
│   │   └── route_names.dart            # Route constants
│   └── services/
│       ├── api_service.dart            # Dio API service
│       └── storage_service.dart        # SharedPreferences wrapper
│
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── auth_remote_data_source.dart
│       │   ├── models/
│       │   │   └── user_model.dart
│       │   └── repositories/
│       │       └── auth_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── user.dart
│       │   └── repositories/
│       │       └── auth_repository.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── auth_cubit.dart
│           │   └── auth_state.dart
│           ├── pages/
│           │   ├── splash_page.dart
│           │   ├── login_page.dart
│           │   ├── register_page.dart
│           │   └── otp_verification_page.dart
│           └── widgets/
│               ├── custom_button.dart
│               ├── custom_text_field.dart
│               └── logout_dialog.dart
│
├── injection_container.dart            # GetIt dependency injection
└── main.dart                           # App entry point
```

## 🔑 Key Technologies

- **State Management**: Flutter Cubit (from flutter_bloc)
- **Dependency Injection**: GetIt
- **Routing**: GoRouter
- **API Calls**: Dio
- **Local Storage**: SharedPreferences
- **Functional Programming**: Dartz (Either)
- **Equality**: Equatable

## 📱 Features Implemented

### 1. User Registration
- Full name (first & last)
- Email validation
- Password strength validation
- Phone number (optional)
- Sends OTP via email after registration

### 2. Email OTP Verification
- 6-digit OTP input with auto-focus
- OTP expiry (10 minutes)
- Resend OTP with countdown timer
- Beautiful UI with helpful messages

### 3. User Login
- Email & password authentication
- Automatic OTP resend for unverified users
- Token-based authentication after successful login

### 4. Session Management
- Automatic token storage
- Persistent login state
- Secure logout functionality

### 5. Splash Screen
- Checks authentication status on app start
- Smooth navigation to appropriate screen

## 🔄 Authentication Flow

### Registration Flow
```
User Registration → OTP Email Sent → User Enters OTP → 
Email Verified → Token Generated → Redirect to Dashboard
```

### Login Flow (Verified User)
```
User Login → Credentials Validated → Token Generated → 
Redirect to Dashboard
```

### Login Flow (Unverified User)
```
User Login → Credentials Validated → New OTP Sent → 
Redirect to OTP Screen → User Verifies → Redirect to Dashboard
```

## 🚀 Setup Instructions

### 1. Backend Configuration

Update the API base URL in `lib/core/constants/api_constants.dart`:

```dart
static const String baseUrl = 'http://your-backend-url:3000';
```

For local development:
- Android Emulator: `http://10.0.2.2:3000`
- iOS Simulator: `http://localhost:3000`
- Physical Device: `http://YOUR_COMPUTER_IP:3000`

### 2. Install Dependencies

```bash
cd agni_pariksha
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

## 📡 API Endpoints Used

All endpoints are defined in `lib/core/constants/api_constants.dart`:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/auth/register` | POST | Register new user |
| `/auth/login` | POST | Login user |
| `/auth/verify-otp` | POST | Verify OTP |
| `/auth/resend-otp` | POST | Resend OTP |

## 🎨 UI Components

### Reusable Widgets

1. **CustomTextField** - Styled text input with validation
2. **CustomButton** - Primary/outlined button with loading state
3. **LogoutDialog** - Confirmation dialog for logout

### Pages

1. **SplashPage** - Initial loading screen with auth check
2. **LoginPage** - User login interface
3. **RegisterPage** - User registration form
4. **OtpVerificationPage** - 6-digit OTP input with resend

## 💾 Local Storage

User data and tokens are securely stored using SharedPreferences:

- **Access Token**: JWT token for API authentication
- **User Data**: User profile information
- **Login Status**: Boolean flag for authentication state

## 🔐 Security Features

1. **Password Validation**: Minimum 8 characters required
2. **Email Validation**: Proper email format validation
3. **Token Management**: Automatic token injection in API headers
4. **OTP Expiry**: 10-minute expiration for OTPs
5. **Secure Storage**: Tokens stored in SharedPreferences

## 🧪 Testing the Flow

### Test Registration
1. Launch app → Redirected to Login
2. Click "Sign Up" → Navigate to Register
3. Fill registration form → Submit
4. Check email for OTP
5. Enter OTP → Verify
6. Redirected to Dashboard

### Test Login (Verified User)
1. Launch app → Login page
2. Enter credentials → Submit
3. Redirected to Dashboard

### Test Login (Unverified User)
1. Launch app → Login page
2. Enter credentials → Submit
3. Redirected to OTP verification
4. Enter OTP → Verify
5. Redirected to Dashboard

## 🐛 Troubleshooting

### Common Issues

**Problem**: Cannot connect to backend
**Solution**: 
- Ensure backend is running
- Check API base URL in `api_constants.dart`
- For emulator, use `10.0.2.2` instead of `localhost`

**Problem**: OTP not received
**Solution**:
- Check backend SMTP configuration
- Verify email address is correct
- Check spam folder
- Try resending OTP

**Problem**: Token not persisting
**Solution**:
- Clear app data and try again
- Check SharedPreferences initialization
- Verify dependency injection setup

## 📦 Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.1      # State management
  go_router: ^14.6.2        # Routing
  get_it: ^8.0.4           # Dependency injection
  dio: ^5.7.0              # HTTP client
  shared_preferences: ^2.3.4  # Local storage
  dartz: ^0.10.1           # Functional programming
  equatable: ^2.0.7        # Value equality
```

## 🔄 State Management

The app uses **Cubit** for state management with clear states:

```dart
- AuthInitial         // Initial state
- AuthLoading         // Loading state
- RegistrationSuccess // After successful registration
- LoginSuccess        // After successful login (verified)
- LoginUnverified     // Login successful but needs verification
- OtpVerificationSuccess // After OTP verification
- OtpResendSuccess    // After OTP resend
- Authenticated       // User is authenticated
- Unauthenticated     // User is not authenticated
- AuthError           // Error state with message
- LogoutSuccess       // After successful logout
```

## 🎯 Next Steps

### Recommended Enhancements

1. **Forgot Password**: Add password reset functionality
2. **Social Login**: Google, Facebook authentication
3. **Biometric Auth**: Fingerprint/Face ID support
4. **Profile Management**: Update user profile
5. **Change Password**: In-app password change
6. **Rate Limiting**: Implement request rate limiting
7. **Offline Support**: Cache user data for offline access

## 📝 Code Examples

### Making Authenticated API Calls

```dart
// The API service automatically adds the token
final response = await apiService.get('/protected-endpoint');
```

### Checking Auth Status

```dart
// In any widget with access to AuthCubit
final authState = context.read<AuthCubit>().state;
if (authState is Authenticated) {
  // User is logged in
}
```

### Logout

```dart
// Show logout dialog
LogoutDialog.show(context);
```

## 🤝 Contributing

When adding new features:
1. Follow the existing architecture pattern
2. Add proper error handling
3. Update this documentation
4. Test all authentication flows

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review the backend API documentation
3. Check backend logs for API errors

---

**Implementation Complete!** ✅

The authentication system is fully functional and ready for use. All screens, API integrations, and state management are working as expected.

