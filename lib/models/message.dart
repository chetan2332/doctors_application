class Message {
  final String recieverId;
  final String senderId;
  final String text;
  final String messageId;
  final DateTime timeSent;

  Message({
    required this.recieverId,
    required this.senderId,
    required this.text,
    required this.messageId,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return {
      'recieverId': recieverId,
      'senderId': senderId,
      'text': text,
      'messageId': messageId,
      'timeSent': timeSent.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      recieverId: map['recieverId'],
      senderId: map['senderId'],
      text: map['text'],
      messageId: map['messageId'],
      timeSent: DateTime.parse(map['timeSent']),
    );
  }
}
