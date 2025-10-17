class ApiConstants {
  // Base URL - Update this with your actual backend URL
  static const String baseUrl = 'http://192.168.1.15:3000';
  
  // API Endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  
  // Headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
  
  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
}

