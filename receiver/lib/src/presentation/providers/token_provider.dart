import 'package:flutter/material.dart';
import 'package:receiver/src/data/repositories/token_repository.dart';
import 'package:receiver/src/injector.dart';

class TokenProvider extends ChangeNotifier {
  TokenRepository tokenRepository = locator<TokenRepository>();

  String? _token;

  String? get token => _token;

  void setToken() async {
    _token = await tokenRepository.getToken();
    notifyListeners();
  }

  void refreshToken() async {
    _token = await tokenRepository.refreshToken();
    notifyListeners();
  }
}
