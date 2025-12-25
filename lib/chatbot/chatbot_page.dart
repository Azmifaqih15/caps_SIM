import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text':
          'Halo 👋\nSaya asisten pelaporan jalan rusak.\nSilakan ceritakan lokasi & kondisi jalan.',
      'isBot': true,
    }
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _controller.text.trim(),
        'isBot': false,
      });

      _controller.clear();

      _messages.add({
        'text':
            'Terima kasih 👍\nApakah kerusakan berupa lubang, retak, atau tergenang air?',
        'isBot': true,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Asisten Jalan Rusak',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ChatBubble(
                  text: msg['text'],
                  isBot: msg['isBot'],
                );
              },
            ),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.yellow.shade100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Tulis laporan di sini...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.yellow.shade700,
            onPressed: _sendMessage,
            child: const Icon(Icons.send, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

/// ⬇⬇⬇ PENTING: CHATBUBBLE HARUS DI LUAR CLASS DI ATAS ⬇⬇⬇

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
                isBot ? Radius.zero : const Radius.circular(16),
            bottomRight:
                isBot ? const Radius.circular(16) : Radius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
