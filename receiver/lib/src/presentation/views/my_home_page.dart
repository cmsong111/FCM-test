import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:receiver/src/presentation/providers/token_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TokenProvider _tokenProvider;
  void permissionRequest() async {
    FirebaseMessaging.instance.requestPermission(
      badge: true,
      alert: true,
      sound: true,
    );
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  void initState() {
    super.initState();
    permissionRequest();

    // 화면 로드 시 토큰을 가져온다. (콜백)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tokenProvider.setToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    _tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firebase Messaging Demo"),
        actions: [
          IconButton(
            onPressed: () {
              _tokenProvider.refreshToken();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ChangeNotifierProvider<TokenProvider>(
          create: (_) => _tokenProvider,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Token:",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                _tokenProvider.token ?? "No token yet",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: _tokenProvider.token ?? ""));
                },
                child: const Text("Copy token"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
