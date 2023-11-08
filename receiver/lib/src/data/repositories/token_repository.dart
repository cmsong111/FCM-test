import 'package:receiver/src/data/datasources/remote_datasource.dart';
import 'package:receiver/src/injector.dart';

class TokenRepository {
  final RemoteDataSource remoteDataSource = locator<RemoteDataSource>();

  Future<String?> getToken() async {
    return await remoteDataSource.getToken();
  }

  Future<String?> refreshToken() async {
    return await remoteDataSource.refreshToken();
  }
}
