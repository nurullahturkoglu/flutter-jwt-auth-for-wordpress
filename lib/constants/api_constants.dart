class ApiConstants {
  // Base URLs
  // Need to change this to your own base URL
  static const String baseUrl = 'https://yourdomain.com/';
  static const String wpApiPath = 'wp-json/jwt-auth/v1/';

  // API Endpoints
  static const String tokenPath = 'token';
  static const String tokenValidatePath = 'token/validate';
  static const String registerPath = 'register';

  // API Response Keys
  static const String responseKeyToken = 'token';
  static const String responseKeyUserId = 'user_id';
  static const String responseKeyUserEmail = 'user_email';
  static const String responseKeyUserNicename = 'user_nicename';
  static const String responseKeyUserDisplayName = 'user_display_name';
  static const String responseKeyUserRole = 'user_role';
  static const String responseKeyMessage = 'message';
  static const String responseKeyStatus = 'status';
  static const String responseKeyCode = 'code';
  static const String responseKeyData = 'data';

  // API Request Keys
  static const String requestKeyUsername = 'username';
  static const String requestKeyPassword = 'password';

  // API Response Codes
  static const String codeValidToken = 'jwt_auth_valid_token';
  static const String codeInvalidToken = 'jwt_auth_invalid_token';
  static const String statusSuccess = 'success';

  // HTTP Headers
  static const String headerAuthorization = 'Authorization';
  static const String bearerPrefix = 'Bearer ';

  // HTTP Status Codes
  static const int statusCodeOk = 200;
  static const int statusCodeForbidden = 403;
}
