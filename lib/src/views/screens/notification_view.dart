import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/src/controllers/notification_controller.dart';

class NotificationView extends StatelessWidget {
  NotificationController notificationController =
      Get.find<NotificationController>();

  NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            RemoteMessage message = notificationController.notifications[index];
            String title = message.notification!.title!;
            String body = message.notification!.body!;
            String payload = jsonEncode(message.data);

            return Card(
              child: ListTile(
                title: Text(title),
                subtitle: Text(body),
                trailing: Text(payload),
              ),
            );
          },
        ),
      ),
    );
  }
}
