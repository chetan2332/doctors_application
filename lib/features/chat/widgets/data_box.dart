import 'package:doctors_app/features/authentication/controller/auth_controller.dart';
import 'package:doctors_app/models/doctors_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class DataBox extends ConsumerWidget {
  const DataBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 300,
      child: StreamBuilder(
          stream: ref.watch(authControllerProvider).getUserDoctorData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Doctor? doctorData = snapshot.data;
              if (doctorData == null) {
                return const Text('doctorData not available');
              }
              return Padding(
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
              );
            }
          }),
    );
  }
}
