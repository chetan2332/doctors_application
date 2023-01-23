import 'package:doctors_app/features/chat/controller/chat_controller.dart';
import 'package:doctors_app/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomChatField extends ConsumerStatefulWidget {
  const BottomChatField(this.patient, {super.key});
  final Patient patient;

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  var isShowSendButton = false;
  var isShowEmojiContainer = false;
  var focusNode = FocusNode();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void sendTextMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }
    ref.read(chatControllerProvider).sendTextMessage(
        context: context,
        text: _messageController.text.trim(),
        patientId: widget.patient.uid);
    setState(() {
      _messageController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: ((value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                }),
                decoration: InputDecoration(
                  hintText: 'Type a message!',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  // fillColor: ,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 6),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        isShowEmojiContainer
                            ? Icons.keyboard
                            : Icons.emoji_emotions,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            splashRadius: 15,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                          // Spacer()
                        ],
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 8),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                  onTap: sendTextMessage,
                  child: Icon(
                    isShowSendButton ? Icons.send : Icons.mic,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isShowEmojiContainer && !focusNode.hasFocus)
          const SizedBox(
            height: 310,
            // child: EmojiPicker(
            //   onEmojiSelected: (category, emoji) {
            //     _messageController.text =
            //         _messageController.text + emoji.emoji;
            //     isShowSendButton = true;
            //     setState(() {});
            //   },
            // ),
          )
      ],
    );
  }
}
