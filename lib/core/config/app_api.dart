//? API configuration and endpoints
class AppApi {
  AppApi._();

  //* Base URL
  static const String baseUrl = 'https://api.workiom.club';

  //* Auth Endpoints
  static const String getCurrentLoginInfo = '/api/services/app/Session/GetCurrentLoginInformations';
  static const String getEditions = '/api/services/app/TenantRegistration/GetEditionsForSelect';
  static const String getPasswordComplexity = '/api/services/app/Profile/GetPasswordComplexitySetting';
  static const String isTenantAvailable = '/api/services/app/Account/IsTenantAvailable';
  static const String registerTenant = '/api/services/app/TenantRegistration/RegisterTenant';
  static const String authenticate = '/api/TokenAuth/Authenticate';
}

