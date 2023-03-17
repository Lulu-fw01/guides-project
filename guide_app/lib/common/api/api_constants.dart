class ApiConstants {
  static String baseUrl = 'http://10.0.2.2:8080/api/v1';
  static String signUpEndpoint = '/auth/sign-up';
  static String loginEndpoint = '/auth';
  static String guideHandling = '/guide-handling';
  static String getGuidesByUserUri = '$baseUrl$guideHandling/get-by-user/info';
}
  //http://localhost:8080/api/v1
  //https://10.0.2.2:8080/api/v1