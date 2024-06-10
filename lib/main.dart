// ignore_for_file: use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_chat/core/utils/injection.dart';
import 'package:get_chat/firebase_options.dart';
import 'package:get_chat/services/firebase/firebase_notification.dart';
import 'package:get_chat/services/firebase/notification.dart';
import 'package:get_chat/services/routes/routes.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final token = await FirebaseMessaging.instance.getToken();
  // print("device token : $token");
  GoRouter router = AppRouter.RouterFun();

  DependencyInjector.inject();

  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatefulWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() async {
    await PushNotifications.init(context);
    await PushNotifications.initLocalNotification(context);
    FCMService().initFirebaseMessaging(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routerConfig: AppRouter().router,
      title: 'ChatApp',
      key: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: widget.router.routeInformationParser,
      routerDelegate: widget.router.routerDelegate,
      routeInformationProvider: widget.router.routeInformationProvider,
    );
  }
}
