# Quick Start Guide - Authentication

## 🚀 Quick Setup (5 minutes)

### Step 1: Update Backend URL

Edit `lib/core/constants/api_constants.dart`:

```dart
static const String baseUrl = 'http://YOUR_BACKEND_URL:3000';
```

**For Testing:**
- Android Emulator: `http://10.0.2.2:3000`
- iOS Simulator: `http://localhost:3000`
- Physical Device: `http://192.168.x.x:3000` (your computer's IP)

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Run the App

```bash
flutter run
```

## 📱 Test the Authentication

### 1. Register a New User

1. App opens → Shows Splash → Redirects to Login
2. Click **"Sign Up"**
3. Fill in:
   - First Name: `John`
   - Last Name: `Doe`
   - Email: `john@example.com`
   - Phone: `1234567890` (optional)
   - Password: `password123`
   - Confirm Password: `password123`
4. Click **"Create Account"**
5. You'll see: "Check your email for OTP"

### 2. Verify Email with OTP

1. Check email for 6-digit OTP
2. Enter the OTP in the verification screen
3. Click **"Verify OTP"**
4. Success! → Redirected to Dashboard

### 3. Login (Next Time)

1. Open app
2. Enter email and password
3. Click **"Login"**
4. Redirected to Dashboard

## 🎨 Available Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Splash | `/` | Initial loading screen |
| Login | `/login` | User login |
| Register | `/register` | User registration |
| OTP Verification | `/otp-verification` | Email verification |
| Dashboard | `/dashboard` | Main app screen |

## 🔐 Key Features

✅ Email-based registration  
✅ OTP verification via email  
✅ Secure login with JWT tokens  
✅ Persistent sessions  
✅ Auto-redirect for unverified users  
✅ Resend OTP with countdown timer  
✅ Password validation  
✅ Email format validation  
✅ Beautiful, modern UI  
✅ Loading states for all actions  

## 💡 Usage Examples

### Add Logout Button to Any Screen

```dart
import 'package:flutter/material.dart';
import '../../features/auth/presentation/widgets/logout_dialog.dart';

// In your widget
IconButton(
  icon: Icon(Icons.logout),
  onPressed: () => LogoutDialog.show(context),
)
```

### Get Current User

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

// In your widget
context.read<AuthCubit>().checkAuthStatus();

// Listen to state
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    if (state is Authenticated) {
      return Text('Hello ${state.user.firstName}');
    }
    return Text('Not logged in');
  },
)
```

### Protect Routes (Already Configured)

The app automatically:
- Redirects unauthenticated users to login
- Redirects authenticated users away from login/register
- Maintains user session across app restarts

## 🔄 Complete Flow Diagram

```
App Start
    ↓
Splash Screen (2s)
    ↓
Check Auth Status
    ↓
┌───────────┴──────────┐
↓                      ↓
Authenticated      Not Authenticated
    ↓                      ↓
Dashboard              Login
                          ↓
                    ┌─────┴─────┐
                    ↓           ↓
                Register    Continue
                    ↓           ↓
            OTP Sent      Verified?
                    ↓           ↓
            OTP Screen    ┌────┴────┐
                    ↓     ↓         ↓
            Verify OTP   Yes       No
                    ↓     ↓         ↓
            Dashboard  Dashboard  OTP Screen
```

## 📝 Environment Setup

Make sure your backend is running with:

```env
# In backend .env file
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
SMTP_FROM=noreply@agnipariksha.com
```

## 🐛 Quick Troubleshooting

**Can't connect to backend?**
```dart
// Use correct URL in api_constants.dart
// Android Emulator: 10.0.2.2
// iOS Simulator: localhost
// Physical Device: Your PC's IP address
```

**OTP not received?**
- Check backend SMTP configuration
- Look in spam folder
- Click "Resend OTP" (wait for countdown)

**App crashes on startup?**
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

## 📦 What Was Installed

The following packages were added to `pubspec.yaml`:

```yaml
dependencies:
  flutter_bloc: ^9.1.1       # State management
  go_router: ^14.6.2         # Navigation
  get_it: ^8.0.4            # Dependency injection
  dio: ^5.7.0               # HTTP client
  shared_preferences: ^2.3.4 # Storage
  dartz: ^0.10.1            # Functional programming
  equatable: ^2.0.7         # State equality
```

## 🎯 What's Next?

You can now:

1. ✅ Register users
2. ✅ Verify emails with OTP
3. ✅ Login users
4. ✅ Maintain sessions
5. ✅ Logout users

**Start building your app features!** The authentication is fully set up and ready to use.

---

Need more details? Check `AUTH_IMPLEMENTATION.md` for complete documentation.

