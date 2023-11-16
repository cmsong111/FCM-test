import 'package:get_it/get_it.dart';
import 'package:receiver/src/data/datasources/firebase_datasource.dart';
import 'package:receiver/src/data/repositories/user_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<FirebaseDataSource>(FirebaseDataSource());
  locator.registerSingleton<UserRepository>(UserRepository());
}
