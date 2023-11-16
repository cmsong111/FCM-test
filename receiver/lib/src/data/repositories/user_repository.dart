import 'package:receiver/src/data/datasources/firebase_datasource.dart';
import 'package:receiver/src/data/models/User.dart';
import 'package:receiver/src/data/models/location_entity.dart';
import 'package:receiver/src/injector.dart';

class UserRepository {
  final FirebaseDataSource _firebaseDataSource = locator<FirebaseDataSource>();

  Future<UserEntity?> getUserInfo() async {
    return await _firebaseDataSource.getUser();
  }

  // Future<String?> refreshToken() async {
  //   return await remoteDataSource.refreshToken();
  // }

  Future<void> updateUserInfo(UserEntity user) async {
    await _firebaseDataSource.updateUser(user);
  }

  Future<List<LocationEntity>> getAllLocationList() async {
    return await _firebaseDataSource.getAllLocationList();
  }
}
