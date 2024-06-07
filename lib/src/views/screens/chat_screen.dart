import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/views/screens/group_chat_view_screen.dart';
import 'package:get_chat/src/views/screens/login_screen.dart';
import 'package:get_chat/src/views/screens/notification_view.dart';
import 'package:get_chat/src/views/screens/single_chat_screen.dart';
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
                context.push('/login');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                // );
              },
            ),
            IconButton(
                onPressed: () {
                  context.pushNamed('notification');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const NotificationView()),
                  // );
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
                context.push('/groupchat');
              },
            ),
            // ListTile(
            //   title: const Text("One to One"),
            //   subtitle: const Text("One to one chat messages"),
            //   leading: const Icon(Icons.person),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SingleChatScreen()),
            //     );
            //   },
            // ),
          ],
        ));
  }
}
