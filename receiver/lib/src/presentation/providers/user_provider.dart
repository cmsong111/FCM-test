import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:receiver/src/data/models/User.dart';
import 'package:receiver/src/data/models/location_entity.dart';
import 'package:receiver/src/data/repositories/user_repository.dart';
import 'package:receiver/src/injector.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = locator<UserRepository>();

  UserEntity user = UserEntity(token: "not initailized", location: []);

  UserProvider() {
    init();
  }

  void init() async {
    UserEntity user = await _userRepository.getUserInfo() ??
        UserEntity(token: "not initailized", location: []);

    this.user = user;
    notifyListeners();
  }

  void addLocation(String location) {
    FirebaseMessaging.instance.subscribeToTopic(location);
    user.location.add(location);
    _userRepository.updateUserInfo(user);
    notifyListeners();
  }

  void removeLocation(int index) {
    FirebaseMessaging.instance.unsubscribeFromTopic(user.location[index]);
    user.location.removeAt(index);
    _userRepository.updateUserInfo(user);
    notifyListeners();
  }

  //토큰 재생성
  void recreateToken() async {
    await FirebaseMessaging.instance.deleteToken();
    user.token = await FirebaseMessaging.instance.getToken();
    _userRepository.updateUserInfo(user);
    notifyListeners();
  }
}
