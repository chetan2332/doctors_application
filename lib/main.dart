import 'package:doctors_app/common/utils/colors.dart';
import 'package:doctors_app/features/authentication/screens/login_screen.dart';
import 'package:doctors_app/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/widgets/error_screen.dart';
import 'features/authentication/controller/auth_controller.dart';
import 'features/chat/screens/patients_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: ref.watch(userDataProvider).when(
          data: (user) {
            if (user == null) {
              return const LoginScreen();
            }
            return const PatientsListScreen();
          },
          error: ((error, stackTrace) {
            return ErrorScreen(error: error.toString());
          }),
          loading: () => const Center(child: CircularProgressIndicator())),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
