import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_app/common/utils/utils.dart';
import 'package:doctors_app/models/message.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  ),
);

class ChatRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore firestore;

  ChatRepository(this._auth, this.firestore);

  Stream<List<Patient>> getPatientsList() {
    final uid = _auth.currentUser!.uid;
    return firestore.collection('doctors/$uid/patients').snapshots().map(
      (event) {
        List<Patient> patients = [];
        for (var document in event.docs) {
          var patient = document.data();
          patients.add(Patient.fromMap(patient));
        }
        return patients;
      },
    );
  }

  Stream<List<Message>> getAllMessagesList(String patientId) {
    final String userId = _auth.currentUser!.uid;
    return firestore
        .collection('patients/$patientId/regDoctors/$userId/chats')
        .orderBy('timeSent')
        .snapshots()
        .map(
      (event) {
        List<Message> messages = [];
        for (var document in event.docs) {
          var message = document.data();
          messages.add(Message.fromMap(message));
        }
        return messages;
      },
    );
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String patientId}) async {
    try {
      final String senderId = _auth.currentUser!.uid;
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      _updateLastMessage(
        text: text,
        doctorId: senderId,
        patientId: patientId,
        timeSent: timeSent,
        messageId: messageId,
      );
      _saveTextMessageToPatientsDatabase(
        text: text,
        patientId: patientId,
        doctorId: senderId,
        timeSent: timeSent,
        messageId: messageId,
      );
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  void _updateLastMessage({
    required String text,
    required String doctorId,
    required String patientId,
    required DateTime timeSent,
    required String messageId,
  }) async {
    var map = {
      'lastMessage': text,
      'senderId': doctorId,
      'recieverId': patientId,
      'timeSent': timeSent
    };
    await firestore
        .collection('doctors/$doctorId/patients/')
        .doc(patientId)
        .set(map, SetOptions(merge: true));
    await firestore
        .collection('patients/$patientId/regDoctors/')
        .doc(doctorId)
        .set(map, SetOptions(merge: true));
  }

  Future<void> _saveTextMessageToPatientsDatabase(
      {required String text,
      required String patientId,
      required String doctorId,
      required DateTime timeSent,
      required String messageId}) async {
    final Message message = Message(
        recieverId: patientId,
        senderId: doctorId,
        text: text,
        messageId: messageId,
        timeSent: timeSent);
    await firestore
        .collection('patients/$patientId/regDoctors/$doctorId/chats')
        .doc(messageId)
        .set(message.toMap());
  }
}
