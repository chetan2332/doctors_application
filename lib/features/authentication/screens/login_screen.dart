import 'package:flutter/material.dart';
import 'package:doctors_app/features/authentication/controller/auth_controller.dart';
import 'package:doctors_app/common/widgets/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final password = TextEditingController();

  void onSignIn() {
    if (emailController.text.isNotEmpty && password.text.isNotEmpty) {
      ref.read(authControllerProvider).loginWithEmail(
            email: emailController.text.trim(),
            password: password.text.trim(),
            context: context,
          );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            const Text(
              'Hello Doctor!',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 100),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            CustomButton(text: 'login', onPressed: onSignIn),
            // CustomButton(
            //     text: 'SignUp Instead',
            //     onPressed: () {
            //       Navigator.of(context)
            //           .pushReplacementNamed(SignUpScreen.routeName);
            //     }),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
