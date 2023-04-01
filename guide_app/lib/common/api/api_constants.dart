class ApiConstants {
  static String baseUrl = 'http://10.0.2.2:8080/api/v1';
  static String signUpEndpoint = '/auth/sign-up';
  static String loginEndpoint = '/auth';
  static String guideHandling = '/guide-handling';
  static String getGuidesByUserUri = '$baseUrl$guideHandling/get-by-user/info';
  static String searchByTitleUri = '$baseUrl/search/title';
  static String searchByAuthorLoginUri = '$baseUrl/search/username';
  static String searchByCategoryNameUri = '$baseUrl/search/category';
  static String favoritesUri = '$baseUrl/favorites';
}
