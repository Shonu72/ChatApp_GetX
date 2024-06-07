import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/utils/constant.dart';
import 'package:get_chat/main.dart';
// import 'package:get_chat/main.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/views/screens/chat_screen.dart';
import 'package:get_chat/src/views/screens/group_chat_view_screen.dart';
import 'package:get_chat/src/views/screens/login_screen.dart';
import 'package:get_chat/src/views/screens/notification_view.dart';
import 'package:get_chat/src/views/screens/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final router = GoRouter(
    redirect: (context, state) {
      final isLoggedIn = Get.find<AuthControllers>().user != null;
      const loggedInPath = '/chat';
      if (!isLoggedIn && state.matchedLocation != '/') {
        return '/';
      } else if (isLoggedIn && state.matchedLocation == '/') {
        return loggedInPath;
      }

      return null;
    },
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
          name: RouteConstnat.login,
          path: '/',
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          name: RouteConstnat.register,
          path: '/register',
          builder: (context, state) => const SignUpScreen()),
      GoRoute(
          name: RouteConstnat.chat,
          path: '/chat',
          builder: (context, state) => ChatScreen()),
      GoRoute(
          name: RouteConstnat.groupchat,
          path: '/groupchat',
          builder: (context, state) => const GroupChatPage()),
      GoRoute(
          name: RouteConstnat.notification,
          path: '/notification',
          builder: ((context, state) {
            return  NotificationView();
          }))
    ],
  );
}
