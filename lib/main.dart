import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/utils/injection.dart';
import 'package:get_chat/services/routes/routes.dart';
import 'package:get_chat/src/views/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjector.inject();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
            

      home: const LoginScreen(),
      // routeInformationParser: AppRouter().router.routeInformationParser,
      // routerDelegate: AppRouter().router.routerDelegate,
    );
  }
}
