import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        height: 200,
        color: Colors.green[200],
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: size.width * 0.4,
              height: 180,
              // color: Colors.white,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(patient.profilePic),
              )),
            ),
          ),
          // const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient.name),
              ],
            ),
          ),
          const Spacer()
        ]),
      ),
    );
  }
}
