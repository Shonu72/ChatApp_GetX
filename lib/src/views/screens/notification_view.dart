import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/src/controllers/notification_controller.dart';
import 'package:go_router/go_router.dart';

class NotificationView extends StatelessWidget {
  final NotificationController notificationController =
      Get.find<NotificationController>();

  NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Notifications'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          )),
      body: Obx(
        () => ListView.builder(
          itemCount: notificationController.notifications.length,
          itemBuilder: (context, index) {
            final notification = notificationController.notifications[index];
            return ListTile(
              title: Text(notification.notification?.title ?? 'No Title'),
              subtitle: Text(notification.notification?.body ?? 'No Body'),
            );
          },
        ),
      ),
    );
  }
}
