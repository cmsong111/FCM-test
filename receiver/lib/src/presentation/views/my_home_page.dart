import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:receiver/src/core/resources/app_constant.dart';
import 'package:receiver/src/presentation/providers/user_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserProvider _userProvider;

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
  }

  // 삭제 다이얼로그
  Future<bool?> deleteLocation(BuildContext context, String location) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("위치 삭제"),
          content: Text("$location 를 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("삭제"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("취소"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firebase Messaging Demo"),
        actions: [
          IconButton(
            onPressed: () {
              _userProvider.init();
              Fluttertoast.showToast(msg: "새로고침 되었습니다.");
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ChangeNotifierProvider<UserProvider>(
          create: (_) => _userProvider,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Token: ",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _userProvider.recreateToken();
                    },
                    child: const Text("new token"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: _userProvider.user.token ?? ""));
                      Fluttertoast.showToast(msg: "복사되었습니다.");
                    },
                    child: const Text("Copy token"),
                  ),
                ],
              ),
              Text(
                _userProvider.user?.token ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "등록된 위치:",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var uid = await Navigator.pushNamed(
                          context, AppRoute.searchLocation);
                      if (uid != null) {
                        _userProvider.addLocation(uid.toString());
                        Fluttertoast.showToast(msg: "추가되었습니다.");
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_userProvider.user.location[index]),
                    onLongPress: () {
                      deleteLocation(
                              context, _userProvider.user.location[index])
                          .then((value) {
                        if (value == true) {
                          _userProvider.removeLocation(index);
                          Fluttertoast.showToast(msg: "삭제되었습니다.");
                        }
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _userProvider.user.location.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
