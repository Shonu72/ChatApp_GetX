import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_chat/services/firebase/firebase_notification.dart';

class NotificationController extends GetxController {
  final FCMService _fcmService = FCMService();

  @override
  void onInit() {
    super.onInit();
  }

  List<RemoteMessage> get notifications => _fcmService.getNotificationList();
}
