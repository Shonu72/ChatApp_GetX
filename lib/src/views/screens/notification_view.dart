import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final RemoteMessage? message =
        GoRouterState.of(context).extra as RemoteMessage?;

    if (message != null) {
      String title = message.notification!.title!;
      String body = message.notification!.body!;
      String payload = jsonEncode(message.data);

      return Scaffold(
        appBar: AppBar(
          title: const Text("Notification Screen"),
        ),
        body: Center(
          child: Column(
            children: [
              Text(title),
              Text(body),
              Text(payload),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Notification Screen"),
        ),
        body: const Center(
          child: Text("No notification"),
        ),
      );
    }
  }
}
