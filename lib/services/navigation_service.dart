import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToNotification() async {
    await navigatorKey.currentContext!.pushNamed('notification');
  }
}
