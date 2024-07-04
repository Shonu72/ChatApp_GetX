import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/utils/constant.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  final AuthControllers authController = Get.find<AuthControllers>();

  ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat Screen"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                authController.signOut();
                context.pushNamed('login');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                // );
              },
            ),
            IconButton(
                onPressed: () {
                  context.pushNamed('notification');
                },
                icon: const Icon(Icons.notifications))
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text("Group Chat"),
              subtitle: const Text("group chat messages"),
              leading: const Icon(Icons.people),
              onTap: () {
                context.goNamed('groupchat');
              },
            ),
            ListTile(
              title: const Text("GoRouter"),
              subtitle: const Text("testing go router params"),
              leading: const Icon(Icons.person),
              onTap: () {
                context.goNamed(
                  'singlechat',
                  pathParameters: {'userID': authController.user!.uid},
                  // extra: {'userID': authController.user!.uid},
                  queryParameters: {'userID' : '123456' }
                );
              },
            ),
          ],
        ));
  }
}
