import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receiver/src/data/models/User.dart';
import 'package:receiver/src/data/models/location_entity.dart';

class FirebaseDataSource {
  Future<UserEntity> getUser() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    print(userUid);

    UserEntity user = await FirebaseFirestore.instance
        .doc("User/$userUid")
        .get()
        .then((value) => UserEntity.fromMap(value.data()!));

    return user;
  }

  Future<void> updateUser(UserEntity user) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.doc("User/$userUid").update(user.toMap());
  }

  /// Location 모든 리스트 가져오기
  Future<List<LocationEntity>> getAllLocationList() async {
    List<LocationEntity> locationList = [];

    await FirebaseFirestore.instance
        .collection("location")
        .get()
        .then((value) => value.docs.forEach((element) {
              locationList.add(LocationEntity(
                  name: element.data()['name'], uid: element.id));
            }));

    return locationList;
  }
}
