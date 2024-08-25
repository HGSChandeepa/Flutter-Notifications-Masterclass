import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageOpener extends StatefulWidget {
  const MessageOpener({super.key});

  @override
  State<MessageOpener> createState() => _MessageOpenerState();
}

class _MessageOpenerState extends State<MessageOpener> {
  //payload data from the notification
  Map<String, dynamic> payload = {};

  @override
  Widget build(BuildContext context) {
    //get the payload data from the notification
    final data = ModalRoute.of(context)!.settings.arguments;

    //check if the data is an instance of RemoteMessage
    if (data is RemoteMessage) {
      payload = data.data;
    }

    //check if the data is an instance of NotificationResponse
    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Received'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Title: ${payload['title']}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Body: ${payload['body']}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
