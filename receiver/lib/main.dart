import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receiver/firebase_options.dart';
import 'package:receiver/src/config/route.dart';
import 'package:receiver/src/core/resources/app_constant.dart';
import 'package:receiver/src/injector.dart';
import 'package:receiver/src/presentation/providers/token_provider.dart';

var initialRoute = AppRoute.login;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();

  FirebaseAuth.instance.currentUser != null
      ? initialRoute = AppRoute.home
      : initialRoute = AppRoute.login;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => TokenProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: appRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
