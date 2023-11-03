import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? token;
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

  void getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {});
  }

  void refresh() async {
    await FirebaseMessaging.instance.deleteToken();
    getToken();
  }

  @override
  void initState() {
    super.initState();
    permissionRequest();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firebase Messaging Demo"),
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Token:",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              token ?? "No token yet",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: token ?? ""));
              },
              child: const Text("Copy token"),
            )
          ],
        ),
      ),
    );
  }
}
