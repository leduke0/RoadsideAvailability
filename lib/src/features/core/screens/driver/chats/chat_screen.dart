import 'package:chop_ya/src/common_widgets/form/search_bar.dart';
import 'package:chop_ya/src/constants/sizes.dart';
import 'package:chop_ya/src/features/core/screens/driver/chats/widgets/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
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
              title: const Text('Chats'),
              centerTitle: true,
            ),
            body: ListView(children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Text('Messages',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal)),
              ),
              const SearchBar(),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 2))
                    ]),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: _buildUserList(),
                ),
              ),
            ])));
  }

  // build a list of users except the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('technicians').snapshots(),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                                receiverUserFullName: data['FullName'],
                                receiverUserId: document.id,
                              )));
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${data['FullName']}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Phone: ${data['Phone']}",
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
    } else {
      return Container();
    }
  }
}
