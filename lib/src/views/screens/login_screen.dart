import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/themes/colors.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/views/screens/sign_up_screen.dart';
import 'package:get_chat/src/views/widgets/app_button.dart';
import 'package:get_chat/src/views/widgets/text_button.dart';
import 'package:get_chat/src/views/widgets/textfield_widget.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isSigningIn = false;
  AuthControllers authController = Get.find<AuthControllers>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor: backgroundDarkColor,
        title: const Text("CHATTER", style: TextStyle(color: textWhiteColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome back to Chatter",
                style: TextStyle(color: textWhiteColor, fontSize: 30),
              ),
              const SizedBox(height: 20),
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                labelText: "Enter your mail",
                controller: mailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
              ),
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Password",
                labelText: "Enter password",
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppButton(
                color: Colors.blue,
                text: "Login",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = mailController.text;
                    final password = passwordController.text;
                    await authController.signIn(
                        email: email, password: password);
                    GoRouter.of(context).goNamed('chat');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>  ChatScreen()));
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: textLightColor,
                thickness: 0.4,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: textWhiteColor, fontSize: 18),
                  ),
                  TextButtonWidget(
                    text: "Sign Up",
                    onPressed: () {
                      // context.pushNamed('register');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
