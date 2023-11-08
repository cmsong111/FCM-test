abstract class RemoteDataSource {
  /// get token from firebase
  Future<String?> getToken();

  /// refresh token from firebase
  Future<String?> refreshToken();
}
