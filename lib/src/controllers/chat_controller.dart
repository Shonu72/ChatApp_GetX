import 'package:get/get.dart';
import 'package:get_chat/src/models/chat_model.dart';

class ChatController extends GetxController {
  final RxList<Message> messages = RxList<Message>([]);

  ChatController();

  void addNewMessage(Message message) {
    messages.add(message);
    update();
  }
}
