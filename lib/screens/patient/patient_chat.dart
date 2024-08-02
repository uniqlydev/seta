import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codingbryant/components/chat_bubble.dart';
import 'package:codingbryant/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientChat extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const PatientChat({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<PatientChat> createState() => _PatientChatState();
}

class _PatientChatState extends State<PatientChat> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/inbox-patient');
          },
        ),
       title: Center(
          child: Text(
            widget.receiverUserEmail,
            style: TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        // title: Text(widget.receiverUserEmail),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, '/inbox-patient');
        //   },
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid) 
      ? Alignment.centerRight
      : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: 
            (data['senderId'] == _firebaseAuth.currentUser!.uid) 
              ? CrossAxisAlignment.end 
              : CrossAxisAlignment.start,
          mainAxisAlignment: 
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'Enter message',
                contentPadding: EdgeInsets.only(left: 15),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}