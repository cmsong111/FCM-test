import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receiver/src/data/models/User.dart';

class FirebaseDataSource {
  Future<UserEntity> getUser() async {
    String userUid = await FirebaseAuth.instance.currentUser!.uid;
    print(userUid);

    UserEntity user = await FirebaseFirestore.instance
        .doc("User/$userUid")
        .get()
        .then((value) => UserEntity.fromMap(value.data()!));

    return user;
  }
}
