import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receiver/src/data/models/User.dart';
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
}
