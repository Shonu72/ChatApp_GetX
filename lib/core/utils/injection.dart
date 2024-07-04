import 'package:get/get.dart';
import 'package:get_chat/services/routes/routes.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/controllers/chat_controller.dart';
import 'package:get_chat/src/controllers/notification_controller.dart';

class DependencyInjector {
  static void inject() {
    // _injectDio();
    initializeController();
  }

  // static void _injectDio() {
  //   final dio = Dio(BaseOptions(baseUrl: AppConstant.baseUrl));
  //   Get.lazyPut<Dio>(() => dio);
  // }

  static void initializeController() {
    // final navigationService = NavigationService().navigateToNotification;
    Get.lazyPut(() => AuthControllers());
    Get.lazyPut(() => ChatController());
    Get.put(NotificationController());
    // Get.put(AppRouter.RouterFun());
  }
}
