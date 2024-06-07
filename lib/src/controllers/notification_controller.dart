import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_chat/main.dart';
import 'package:get_chat/services/firebase/notification.dart';
// import 'package:get_chat/src/views/screens/notification_view.dart';
import 'package:go_router/go_router.dart';

class NotificationController extends GetxController {
  final RxList<RemoteMessage> notifications = RxList<RemoteMessage>([]);

  @override
  void onInit() {
    super.onInit();
    initFirebaseMessaging();
  }

// initialize firebase messaging
  Future<void> initFirebaseMessaging() async {
    await PushNotifications.init();
    await PushNotifications.initLocalNotification();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("background notification tapped $message");
        notifications.add(message);
        navigatorKey.currentContext!.push('/notification');
      }
    });
// get foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      print("Foreground message received");

      if (message.notification != null) {
        print("Foreground message received : ${message.notification!.body}");
        notifications.add(message);
        PushNotifications.showSampleNotifcation(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData,
        );
      }
    });
    // get initial message
    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print("terminated state notification tapped : $message");
      notifications.add(message);
      navigatorKey.currentContext!.push('/notification');
    }
  }

  // background message handler
  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (message.notification != null) {
      print("Background message received : ${message.notification!.body}");
      notifications.add(message);
    }
  }

  List<RemoteMessage> getNotificationList() => notifications.toList();
}
