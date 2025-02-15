import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String driverName;
  final String driverId;
  const ChatScreen({Key? key, required this.driverName, required this.driverId}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.driverName}')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('chats')
                  .doc(_getChatId())
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data.docs[index];
                    bool isMe = message['senderId'] == _auth.currentUser?.uid;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blueAccent.withOpacity(0.8) : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(message['senderName'] ?? '',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
                            Text(message['text'] ?? '', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
  
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
        ],
      ),
    );
  }
  
  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    var user = _auth.currentUser;
    var message = {
      'text': _messageController.text.trim(),
      'senderId': user?.uid,
      'senderName': user?.displayName ?? 'Customer',
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('chats').doc(_getChatId()).collection('messages').add(message);
    _messageController.clear();
  }
  
  String _getChatId() {
    var userId = _auth.currentUser?.uid ?? '';
    var driverId = widget.driverId;
    return userId.compareTo(driverId) > 0 ? '$userId\_$driverId' : '$driverId\_$userId';
  }
}
