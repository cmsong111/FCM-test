import 'package:receiver/src/core/resources/app_constant.dart';
import 'package:receiver/src/presentation/views/login_page.dart';
import 'package:receiver/src/presentation/views/my_home_page.dart';

var appRoute = {
  AppRoute.home: (context) => const MyHomePage(),
  AppRoute.login: (context) => const LoginPage(),
};
