import 'package:get/get.dart';
import 'package:get_chat/core/utils/constant.dart';
import 'package:get_chat/src/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final RxList<Message> messages = RxList<Message>([]);
  late IO.Socket _socket;

  ChatController();

  void initSocket(String username) {
    _socket = IO.io(
      AppConstant.socketUrl,
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': username}).build(),
    );
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on(
      'message',
      (data) => addNewMessage(Message.fromJson(data)),
    );
  }

  void disposeSocket() {
    _socket.dispose();
  }

  void sendMessage(String message, String sender) {
    _socket.emit('message', {
      'message': message,
      'sender': sender,
    });
  }

  void addNewMessage(Message message) {
    messages.add(message);
    update();
  }
}
