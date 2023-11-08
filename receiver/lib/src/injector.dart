import 'package:get_it/get_it.dart';
import 'package:receiver/src/data/datasources/firebase_datasource.dart';
import 'package:receiver/src/data/datasources/remote_datasource.dart';
import 'package:receiver/src/data/repositories/token_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<RemoteDataSource>(FirebaseDataSource());
  locator.registerSingleton<TokenRepository>(TokenRepository());
}
