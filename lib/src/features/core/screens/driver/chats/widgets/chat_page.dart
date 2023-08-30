import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/features/core/screens/driver/chats/widgets/chat_bubble.dart';
import 'package:chop_ya/src/features/core/screens/driver/chats/widgets/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserId;
  final String receiverUserFullName;

  const ChatPage(
      {super.key,
      required this.receiverUserId,
      required this.receiverUserFullName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if the message text field is not empty
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      // clear the message text field
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.receiverUserFullName),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // messages list
              Expanded(
                child: _buildMessageList(),
              ),

              // message input field
              _buildMessageInput(),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // build the message list
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align the message to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.end, 
        children: [
        // Text(data['senderEmail']),
        const SizedBox(
          height: 5,
        ),
        ChatBubble(message: data['message']),
        const SizedBox(
          height: 5,
        ),
        // get the time the message was sent
        Text(
          data['timestamp'].toDate().toString().substring(10, 16),
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ]),
    );
  }

  // build message input field
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          // textfield
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              ),
            ),
          ),

          // send button
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 30,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
