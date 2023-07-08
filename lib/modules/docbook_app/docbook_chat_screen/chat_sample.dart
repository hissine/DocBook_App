import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:ramdan_proj/shared/styles/colors.dart';

class ChatSample extends StatelessWidget {
  const ChatSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 80),
          child: ClipPath(
            clipper: UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: const Text(
                'Hello, What i can do for you, you book appointment directly',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 80),
            child: ClipPath(
              clipper: LowerNipMessageClipper(MessageType.send),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  bottom: 25,
                  right: 20,
                ),
                decoration:  BoxDecoration(
                  color: defColor,
                ),
                child: const Text(
                  'Hello Doctor Are you there?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
