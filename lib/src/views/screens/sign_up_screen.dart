import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/themes/colors.dart';
import 'package:get_chat/src/controllers/auth_controllers.dart';
import 'package:get_chat/src/views/screens/chat_screen.dart';
import 'package:get_chat/src/views/screens/group_chat_view_screen.dart';
import 'package:get_chat/src/views/widgets/app_button.dart';
import 'package:get_chat/src/views/widgets/textfield_widget.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isSigningUp = false;

  AuthControllers authController = Get.find<AuthControllers>();

  @override
  Widget build(BuildContext context) {
    void validateForm() {
      if (_formKey.currentState!.validate()) {}
    }

    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
          backgroundColor: backgroundDarkColor,
          title: const Text("CHATTER", style: TextStyle(color: textWhiteColor)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: textWhiteColor,
            ),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Register to Chatter",
                style: TextStyle(color: textWhiteColor, fontSize: 30),
              ),
              const SizedBox(height: 20),
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.person),
                keyboardType: TextInputType.name,
                hintText: "Name",
                labelText: "Enter your name",
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),
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
              // AuthTextFieldWidget(
              //   prefixIcon: const Icon(Icons.lock),
              //   obscureText: true,
              //   keyboardType: TextInputType.visiblePassword,
              //   hintText: "Confirm Password",
              //   labelText: "Confirm your password",
              //   controller: confirmPasswordController,
              //   validator: (value) {
              //     if (passwordController.text !=
              //         confirmPasswordController.text) {
              //       return "Password does not match";
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 20),
              AppButton(
                color: Colors.blue,
                text: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.register(
                        name: nameController.text.trim(),
                        email: mailController.text,
                        password: passwordController.text);
                    context.goNamed('chat');
                    // MaterialPageRoute(builder: (context) =>  ChatScreen());
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
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
                    "Already have an account?",
                    style: TextStyle(color: textWhiteColor, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed('login');
                    },
                    child: const Text(
                      "login",
                      style: TextStyle(color: primaryColor, fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      _isSigningUp = true;
    });
  }
}
