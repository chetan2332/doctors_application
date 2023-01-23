import 'package:doctors_app/common/utils/colors.dart';
import 'package:doctors_app/common/widgets/custom_button.dart';
import 'package:doctors_app/features/authentication/controller/auth_controller.dart';
import 'package:doctors_app/features/authentication/screens/edit_profile_screen.dart';
import 'package:doctors_app/features/authentication/screens/login_screen.dart';
import 'package:doctors_app/models/doctors_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  static const routeName = '/profile-screen';
  const ProfileScreen({super.key});

  void signOut(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider).signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProfileScreen.routeName);
              },
              icon: const Icon(Icons.mode_edit))
        ],
      ),
      body: StreamBuilder<Doctor>(
          stream: ref.watch(authControllerProvider).getUserDoctorData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('No Profile Data Available'),
              );
            }
            Doctor doctorData = snapshot.data!;
            return Column(children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(doctorData.profilePic),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        const Text('Name'),
                        Text('Dr. ${doctorData.name}')
                      ],
                    ),
                    TableRow(
                      children: [const Text('Spec'), Text(doctorData.spec)],
                    ),
                    TableRow(
                      children: [
                        const Text('Enrolled'),
                        Text(doctorData.enrolled.toString())
                      ],
                    )
                  ],
                ),
              ),
              CustomButton(
                  text: 'SignOut', onPressed: () => signOut(ref, context))
            ]);
          }),
    );
  }
}
