import 'package:receiver/src/data/datasources/firebase_datasource.dart';
import 'package:receiver/src/data/models/User.dart';
import 'package:receiver/src/injector.dart';

class UserRepository {
  final FirebaseDataSource remoteDataSource = locator<FirebaseDataSource>();

  Future<UserEntity?> getUserInfo() async {
    return await remoteDataSource.getUser();
  }

  // Future<String?> refreshToken() async {
  //   return await remoteDataSource.refreshToken();
  // }
}
