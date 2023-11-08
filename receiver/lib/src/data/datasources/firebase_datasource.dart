import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:receiver/src/data/datasources/remote_datasource.dart';

class FirebaseDataSource implements RemoteDataSource {
  @override
  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  Future<String?> refreshToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return FirebaseMessaging.instance.getToken();
  }
}
