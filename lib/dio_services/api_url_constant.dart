class AppConstant {

  static const baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const getUser = 'users';
  static String getAlbumDataByUserId(int userId) {
    return '${baseUrl}albums?userId=$userId';
  }
}
