import 'dart:developer';

import 'package:chop_ya/src/features/core/screens/driver/chats/widgets/chat_page.dart';
import 'package:chop_ya/src/features/core/screens/technician/chats/widgets/chat_service.dart';
import 'package:chop_ya/src/repository/driver_repository/driver_repository.dart';
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
    final chatService = ChatService();

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
      body: _buildChatroomList(),
    ));
  }

    // build a list of users except the current logged in user
  Widget _buildChatroomList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatService.getReceiverChatrooms(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error, Something went wrong ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListTile(doc))
              .toList(),
        );
      },
    );
  }

  // build individaul user list item
  Widget _buildUserListTile(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all the user except the current logged in user
    return FutureBuilder(
        future: DriverRepository().getDriverData(driverId: data['sender_id']),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('No data found');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: const CircleAvatar(
                        radius: 35,
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        log('user id is ${document.id}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      receiverUserFullName: snapshot.data!.fullName,
                                      receiverUserId: data['sender_id'],
                                    )));
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name: ${snapshot.data!.fullName}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Phone: ${snapshot.data!.phoneNo}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0,
                  indent: 20,
                  endIndent: 20,
                )
              ],
            );
          }
          return CircularProgressIndicator();
        });
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
