import 'package:flutter/material.dart';
import 'package:get_chat/core/utils/constant.dart';
import 'package:get_chat/src/views/screens/chat_screen.dart';
import 'package:get_chat/src/views/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouteConstnat.login,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginScreen());
        },
      ),
      GoRoute(
        name: RouteConstnat.chat,
        path: '/chat',
        pageBuilder: (context, state) {
          final username = state.pathParameters['username'] as String;
          return MaterialPage(child: ChatPage(username: username));
        },
      ),
    ],
  );
}
