import 'package:doctors_app/features/authentication/screens/login_screen.dart';
import 'package:doctors_app/features/authentication/screens/profile_screen.dart';
import 'package:doctors_app/features/authentication/screens/user_information_screen.dart';
import 'package:doctors_app/features/chat/screens/chat_screen.dart';
import 'package:doctors_app/features/chat/screens/patients_list_screen.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'common/widgets/error_screen.dart';
import 'features/authentication/screens/edit_profile_screen.dart';
import 'features/authentication/screens/signup_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    case PatientsListScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const PatientsListScreen());

    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const UserInformationScreen());

    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileScreen());

    case EditProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => const EditProfileScreen());

    case ChatScreen.routeName:
      final patient = settings.arguments as Patient;
      return MaterialPageRoute(
          builder: (context) => ChatScreen(patient: patient));

    default:
      return MaterialPageRoute(
          builder: ((context) =>
              const ErrorScreen(error: 'This page doesn\'t exist')));
  }
}
