import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/themes/colors.dart';
import 'package:get_chat/core/utils/constant.dart';
import 'package:get_chat/src/controllers/chat_controller.dart';
import 'package:get_chat/src/models/chat_model.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  final String username;
  const ChatPage({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  ChatController chatController = Get.find<ChatController>();
  _sendMessage() {
    _socket.emit('message', {
      'message': _messageInputController.text.trim(),
      'sender': widget.username
    });
    _messageInputController.clear();
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on(
      'message',
      (data) => chatController.addNewMessage(
        Message.fromJson(data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _socket = IO.io(
      AppConstant.socketUrl,
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': widget.username}).build(),
    );
    _connectSocket();
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    _socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("chatting "),
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
                    alignment: message.senderUsername == widget.username
                        ? WrapAlignment.end
                        : WrapAlignment.start,
                    children: [
                      Card(
                        color: message.senderUsername == widget.username
                            ? textWhiteColor
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                message.senderUsername == widget.username
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
                        _sendMessage();
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
