import 'package:flutter/material.dart';

import '../constans.dart';

class ChatBubbleRTL extends StatelessWidget {
  final String message;

  ChatBubbleRTL({required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}

class ChatBubbleLTR extends StatelessWidget {
  final String message;

  ChatBubbleLTR({required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }
}
