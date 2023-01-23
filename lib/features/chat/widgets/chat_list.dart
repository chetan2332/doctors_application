import 'package:doctors_app/features/chat/controller/chat_controller.dart';
import 'package:doctors_app/features/chat/widgets/my_message_card.dart';
import 'package:doctors_app/features/chat/widgets/sender_message_card.dart';
import 'package:doctors_app/models/message.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerStatefulWidget {
  final Patient patient;
  const ChatList(this.patient, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final messageController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .watch(chatControllerProvider)
            .getAllMessagesList(widget.patient.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('No conversation begin till now'),
            );
          }

          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              if (messageData.recieverId == widget.patient.uid) {
                return MyMessageCard(
                  message: messageData,
                );
              }
              return SenderMessageCard(
                message: messageData,
              );
            },
          );
        });
  }
}
