import 'package:flutter/material.dart';


class ChatBubble extends StatelessWidget {
  final String text;
  final bool isBot;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isBot,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isBot ? Colors.yellow.shade300 : Colors.yellow.shade700,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft:
                isBot ? const Radius.circular(0) : const Radius.circular(16),
            bottomRight:
                isBot ? const Radius.circular(16) : const Radius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isBot ? Colors.black : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
