import 'dart:convert';

import 'package:firebase_cloud_messaging_flutter/firebase_cloud_messaging_flutter.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class FcmSend {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  String filePath = 'json/firebase_admin_sdk.json';

  late FirebaseCloudMessagingServer server;

  // 초기화
  void init() async {
    String json = await rootBundle.loadString(filePath);
    server = FirebaseCloudMessagingServer(jsonDecode(json));
  }

  // 생성자
  FcmSend() {
    init();
  }

  // 메시지 전송
  Future<ServerResult> sendMessageWithToken(
      {required String title,
      required String message,
      required String token}) async {
    return server.send(
      FirebaseSend(
        validateOnly: false,
        message: FirebaseMessage(
          notification: FirebaseNotification(
            title: title,
            body: message,
          ),
          android: const FirebaseAndroidConfig(
            ttl: '60s',
          ),
          token: token,
        ),
      ),
    );
  }

  // 메시지 전송
  Future<ServerResult> sendMessageWithTopic(
      {required String title,
      required String message,
      required String topic}) async {
    return server.send(
      FirebaseSend(
        validateOnly: false,
        message: FirebaseMessage(
          notification: FirebaseNotification(
            title: title,
            body: message,
          ),
          android: const FirebaseAndroidConfig(
            ttl: '60s',
          ),
          topic: topic,
        ),
      ),
    );
  }
}
