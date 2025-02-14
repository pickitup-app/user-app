import 'package:flutter/material.dart';
import '../components/chat_bubble.dart';
import '../components/bottom_navigation_bar.dart' as custom_nav;
import '../components/header_component.dart' as header;

class ChatExpirioScreen extends StatefulWidget {
  @override
  _ChatExpirioScreenState createState() => _ChatExpirioScreenState();
}

class _ChatExpirioScreenState extends State<ChatExpirioScreen> {
  final List<Map<String, dynamic>> messages = [
    {"text": "Hello Expirio, how should I dispose bleach?", "isUser": true},
    {
      "text": "How to Dispose of Bleach Safely\n\n"
          "1. Small Amounts:\n"
          "- Dilute with plenty of water and pour down the sink or toilet.\n"
          "- Do not mix with other chemicals.\n\n"
          "2. Large Amounts:\n"
          "- Take to a hazardous waste disposal facility.\n\n"
          "3. Container:\n"
          "- Rinse thoroughly and recycle if permitted.\n\n"
          "4. Safety Tips:\n"
          "- Ensure good ventilation, wear gloves, and keep away from children and pets.",
      "isUser": false
    },
    {"text": "Where should I throw empty bleach bottle?", "isUser": true},
    {
      "text":
          "You should throw an empty bleach bottle in the B3 (Hazardous Waste) bin. This is because bleach bottles previously contained hazardous chemicals, making them suitable for the B3 category, even if rinsed.",
      "isUser": false
    },
    {"text": "Thank you, Expirio!", "isUser": true},
    {"text": "You're welcome! Stay safe.", "isUser": false},
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    setState(() {
      messages.add({"text": text, "isUser": true});
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Tinggi header
        child: header.HeaderComponent(
            "Expirio"), // HeaderComponent dipanggil di sini
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                return ChatBubble(
                  message: message["text"],
                  isUser: message["isUser"],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                  heroTag: "chat_send_button",
                  child: Icon(Icons.send),
                  backgroundColor: Colors.green[400],
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          custom_nav.BottomNavigationBar(), // Gunakan BottomNavigationBar
    );
  }
}
