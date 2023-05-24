import 'package:scholar_chat/constans.dart';

class Message {
  final String message;
  Message(
    this.message,
  );

  factory Message.fromJson(jsonData) {
    return Message(jsonData[KMessage]);
  }
}
