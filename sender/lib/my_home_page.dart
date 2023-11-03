import 'package:firebase_cloud_messaging_flutter/firebase_cloud_messaging_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sender/fcm_send.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FcmSend fcmSend = FcmSend();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  void _sendMessage() async {
    ServerResult result = await fcmSend.sendMessage(
      title: titleController.text,
      message: messageController.text,
      token: tokenController.text,
    );

    if (result.successful) {
      Fluttertoast.showToast(msg: "메시지 전송 성공");
    } else {
      Fluttertoast.showToast(msg: "메시지 전송 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firebase Messaging Sender"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '알림 제목',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '알림 내용',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: tokenController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '토큰',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _sendMessage();
              },
              child: const Text("문자 전송"),
            )
          ],
        ),
      ),
    );
  }
}
