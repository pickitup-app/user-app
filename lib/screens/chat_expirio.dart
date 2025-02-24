import 'package:flutter/material.dart';
import '../components/chat_bubble.dart';
import '../components/bottom_navigation_bar.dart' as custom_nav;
import '../components/header_component.dart' as header;
import '../services/api_service.dart';

class ChatExpirioScreen extends StatefulWidget {
  @override
  _ChatExpirioScreenState createState() => _ChatExpirioScreenState();
}

class _ChatExpirioScreenState extends State<ChatExpirioScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Helper method to check if the given value represents a bot message.
  bool _isBot(dynamic isBotValue) {
    final value = isBotValue.toString().toLowerCase();
    return value == 'true' || value == '1';
  }

  // Scroll to the bottom when new messages are added.
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _loadChats() async {
    final result = await _apiService.getChats();
    if (result['success'] == true && result['data'] != null) {
      setState(() {
        messages.clear();
        for (var chat in result['data']) {
          messages.add({
            "text": chat['message'],
            // If is_bot is true then it is a bot response (display on left).
            "isUser": _isBot(chat['is_bot']) ? false : true,
          });
        }
      });
      _scrollToBottom();
    } else {
      debugPrint("Error loading chats: ${result['message']}");
    }
  }

  Future<void> _sendMessage(String text) async {
    // Append user's message (optimistic update) and show typing indicator.
    setState(() {
      messages.add({"text": text, "isUser": true});
      _isTyping = true;
    });
    _controller.clear();
    _scrollToBottom();

    final result = await _apiService.sendChat(text);
    if (result['success'] == true && result['data'] != null) {
      // Instead of clearing the conversation completely,
      // we update the conversation only if the new result shows progress.
      final List<dynamic> resultChats = result['data'];
      if (resultChats.length > messages.length) {
        setState(() {
          messages.clear();
          for (var chat in resultChats) {
            messages.add({
              "text": chat['message'],
              "isUser": _isBot(chat['is_bot']) ? false : true,
            });
          }
          _isTyping = false;
        });
      } else {
        setState(() {
          _isTyping = false;
        });
      }
      _scrollToBottom();
    } else {
      setState(() {
        _isTyping = false;
      });
      debugPrint("Error sending chat: ${result['message']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total items: messages plus typing indicator if active.
    final itemCount = messages.length + (_isTyping ? 1 : 0);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: header.HeaderComponent("Expirio"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index < messages.length) {
                  final message = messages[index];
                  return ChatBubble(
                    message: message["text"],
                    isUser: message["isUser"],
                  );
                } else {
                  // Show a typing indicator bubble.
                  return ChatBubble(
                    message: "Typing...",
                    isUser: false,
                  );
                }
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
      bottomNavigationBar: custom_nav.CustomBottomNavigationBar(),
    );
  }
}
