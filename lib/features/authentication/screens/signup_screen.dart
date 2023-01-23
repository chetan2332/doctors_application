import 'package:flutter/material.dart';
import 'package:doctors_app/common/widgets/custom_button.dart';
import 'package:doctors_app/features/authentication/controller/auth_controller.dart';
import 'package:doctors_app/features/authentication/screens/login_screen.dart';
// ignore: unused_import
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = '/signUp-screen';

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final password = TextEditingController();

  void onSignUp() {
    if (emailController.text.isNotEmpty && password.text.isNotEmpty) {
      ref.read(authControllerProvider).signUpWithEmail(
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
            const Spacer(),
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
            CustomButton(text: 'SignUp', onPressed: onSignUp),
            CustomButton(
                text: 'Login Instead',
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
