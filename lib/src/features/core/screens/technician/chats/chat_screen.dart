import 'package:chop_ya/src/features/core/screens/driver/chats/widgets/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Technician Screen'),
        centerTitle: true,
      ),
      body: _buildUserList(),
    ));
  }

  // build a list of users except the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('drivers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error, Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  // build individaul user list item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all the user except the current logged in user
    if (_auth.currentUser!.email != data['Email']) {
      return ListTile(
        title: Text(data['FullName']),
        subtitle: Text(data['Email']),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  ChatPage(
                receiverUserFullName: data['FullName'],
                receiverUserId: document.id,
              ),
              ),
              // const TechnicianDetailsScreen()
          );
        },
      );
    } else {
      return  Container();

    }
  }
}
