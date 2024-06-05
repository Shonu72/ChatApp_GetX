import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/utils/constant.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/controllers/chat_controller.dart';

class DependencyInjector {
  static void inject() {
    _injectDio();
    initializeController();
  }

  static void _injectDio() {
    final dio = Dio(BaseOptions(baseUrl: AppConstant.baseUrl));
    Get.lazyPut<Dio>(() => dio);
  }

  static void initializeController() {
    Get.lazyPut(() => AuthControllers());
    Get.lazyPut(() => ChatController());
  }
}
