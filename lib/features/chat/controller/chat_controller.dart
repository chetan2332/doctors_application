import 'package:doctors_app/features/chat/repository/chat_repository.dart';
import 'package:doctors_app/models/message.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider(
  (ref) {
    final chatRepository = ref.watch(chatRepositoryProvider);
    return ChatController(chatRepository);
  },
);

class ChatController {
  final ChatRepository chatRepository;

  ChatController(this.chatRepository);

  Stream<List<Patient>> getPatientsList() {
    return chatRepository.getPatientsList();
  }

  Stream<List<Message>> getAllMessagesList(String patientId) {
    return chatRepository.getAllMessagesList(patientId);
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String patientId,
  }) {
    chatRepository.sendTextMessage(
        context: context, text: text, patientId: patientId);
  }
}
