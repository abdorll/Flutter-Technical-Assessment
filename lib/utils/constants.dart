// ignore_for_file: non_constant_identifier_names

class Constants {
  static String APP_NAME = "Kooha";
  static String USER_BOX = "USER_BOX";
  static String RECOGNIZED_USER = 'RECOGNIZED_USER';
  static String CURRENT_SCREEN = "";
  static String BASE_URL = "https://dev-api.kooha.com/v1/";
  static String TOKEN_KEY = "token";
  static String CACHED_EMAIL = "";
  static String CURRENCY = "₦";
  static String CACHED_PASSWORD = "";
  static String CACHED_EMAIL_KEY = "cached_email_key";
  static String CACHED_PASSWORD_KEY = "cached_password_key";
  static String TOKEN_DATA = "";
  static String FRESH_LOGIN = "fresh_login";
  static set setTokenSata(e) => Constants.TOKEN_DATA = e;
  static get getTokenData => Constants.TOKEN_DATA;
}
