import 'package:doctors_app/common/utils/colors.dart';
import 'package:doctors_app/features/chat/widgets/bottom_text_field.dart';
import 'package:doctors_app/features/chat/widgets/chat_list.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat-screen';
  final Patient patient;
  const ChatScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name),
        backgroundColor: greenColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(patient),
          ),
          BottomChatField(patient),
        ],
      ),
    );
  }
}
