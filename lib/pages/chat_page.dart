import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/constans.dart';

import '../models/message.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_bubbles.dart';

class ChatPage extends StatefulWidget {
  static String id = 'chat-page';

  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  TextEditingController controller = TextEditingController();
  void sendMessage(data, email) {
    messages.add({KMessage: data, KCreatedAt: DateTime.now(), 'id': email});
    controller.text = '';
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    const Text(
                      "Chat",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messageList[index].id == email
                            ? ChatBubbleLTR(message: messageList[index].message)
                            : ChatBubbleRTL(
                                message: messageList[index].message);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        sendMessage(data, email);
                        _controller.animateTo(
                          0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Type your message here',
                        hintStyle: const TextStyle(color: kPrimaryColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send, color: kPrimaryColor),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Loading...');
          }
        });
  }
}
