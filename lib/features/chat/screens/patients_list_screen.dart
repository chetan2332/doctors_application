import 'package:doctors_app/common/utils/colors.dart';
import 'package:doctors_app/features/authentication/screens/profile_screen.dart';
import 'package:doctors_app/features/chat/controller/chat_controller.dart';
import 'package:doctors_app/features/chat/screens/chat_screen.dart';
import 'package:doctors_app/features/chat/widgets/patient_card.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class PatientsListScreen extends ConsumerWidget {
  static const routeName = '/patients-list-screen';
  const PatientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Patients'),
        backgroundColor: greenColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              icon: const Icon(Icons.account_box_rounded))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<Patient>>(
              stream: ref.watch(chatControllerProvider).getPatientsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Patient>? patients = snapshot.data;
                if (patients == null) {
                  return const Center(
                    child: Text('No data reached here'),
                  );
                }
                if (patients.isEmpty) {
                  return const Center(
                    child: Text('You don\'t have any patients registered'),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    child: PatientCard(patient: patients[index]),
                    onTap: () {
                      Navigator.of(context).pushNamed(ChatScreen.routeName,
                          arguments: patients[index]);
                    },
                  ),
                  itemCount: patients.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
