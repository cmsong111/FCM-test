import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:receiver/src/data/datasources/remote_datasource.dart';

class FirebaseDataSource implements RemoteDataSource {
  @override
  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "FcmToken": token,
      "locate": "/location/Busan/Busanjin-gu/Hwaji-ro"
    });

    return token;
  }

  @override
  Future<String?> refreshToken() async {
    await FirebaseMessaging.instance.deleteToken();
    return getToken();
  }
}
