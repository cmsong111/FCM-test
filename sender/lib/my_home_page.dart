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
  TextEditingController topicController = TextEditingController();

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  void _sendMessageByToken() async {
    ServerResult result = await fcmSend.sendMessageWithToken(
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

  void _sendMessageByTopic() async {
    ServerResult result = await fcmSend.sendMessageWithTopic(
      title: titleController.text,
      message: messageController.text,
      topic: topicController.text,
    );

    if (result.successful) {
      Fluttertoast.showToast(msg: "topic 메시지 전송 성공");
    } else {
      Fluttertoast.showToast(msg: "topic 메시지 전송 실패");
      print(result.errorPhrase);
    }
  }

  int fcmMode = 0;

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
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Radio(
                          value: 0,
                          groupValue: fcmMode,
                          onChanged: (index) {
                            setState(() {
                              fcmMode = index as int;
                            });
                          }),
                      const Expanded(
                          child: Text('Topic', style: TextStyle(fontSize: 17)))
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: fcmMode,
                          onChanged: (index) {
                            setState(() {
                              fcmMode = index as int;
                            });
                          }),
                      const Expanded(
                          child: Text('Token', style: TextStyle(fontSize: 17)))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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
              controller: fcmMode == 0 ? topicController : tokenController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: fcmMode == 0 ? 'Topic' : 'Token',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                fcmMode == 0 ? _sendMessageByTopic() : _sendMessageByToken();
              },
              child: const Text("문자 전송"),
            )
          ],
        ),
      ),
    );
  }
}
