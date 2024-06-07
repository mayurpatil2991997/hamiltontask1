class AppConstant {

  static const baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const getUser = 'users';
  static const getAlbum = 'albums';
  static String getAlbumDataByUserId(int userId) {
    return '${baseUrl}albums?userId=$userId';
  }
  static String getPhotoDataByAlbumId(int albumId) {
    return '${baseUrl}photos?albumId=$albumId';
  }
}
