import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/themes/colors.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/controllers/chat_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class GroupChatPage extends StatefulWidget {
  // final String? username;
  const GroupChatPage({Key? key}) : super(key: key);

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  final TextEditingController _messageInputController = TextEditingController();
  ChatController chatController = Get.find<ChatController>();
  final username = Get.find<AuthControllers>().user!.uid;
  @override
  void initState() {
    super.initState();
    chatController.initSocket(username);
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
    chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Chat view "),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetX<ChatController>(
              builder: (controller) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Wrap(
                    alignment: message.senderUsername == username
                        ? WrapAlignment.end
                        : WrapAlignment.start,
                    children: [
                      Card(
                        color: message.senderUsername == username
                            ? textWhiteColor
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                message.senderUsername == username
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(message.message),
                              Text(
                                DateFormat('hh:mm a').format(message.sentAt),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(height: 5),
                itemCount: controller.messages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageInputController.text.trim().isNotEmpty) {
                        chatController.sendMessage(
                          _messageInputController.text.trim(),
                          username,
                        );
                        _messageInputController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
