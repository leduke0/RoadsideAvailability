import 'dart:developer';

import 'package:chop_ya/src/features/core/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // Send Message
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user
    final User user = _firebaseAuth.currentUser!;
    final uid = user.uid;
    // final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!.toString();
    final Timestamp timeStamp = Timestamp.now();  // get current time





    // Create a new message
    Message newMessage = Message(
      senderId: uid,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timeStamp, 
    );


    // construct a chat room id from current user id and receiver id (sorted to ensure uniqueness)
    List<String> userIds = [uid, receiverId];
    userIds.sort(); // sort the list(this ensures the chat room id is unique and remains the same for both users)
    String chatRoomId = userIds.join(
        "_"); // join the sorted list to create a unique chat room id


    // add new message to database
    await _firestore
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

   Stream<QuerySnapshot> getReceiverChatrooms() {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> query = _firestore
          .collection("chatrooms")
          .where(Filter.or(
              Filter("receiver_id", isEqualTo: _firebaseAuth.currentUser!.uid),
              Filter("sender_id", isEqualTo: _firebaseAuth.currentUser!.uid)))
          .orderBy("timestamp", descending: false)
          .snapshots();

      log('Snapshot returen: ${query.toString()}');
      return query;
    } on FirebaseException catch (e, stackTrace) {
      log('failed getting chatrooms, with error ${e.message} and stacktrace ${stackTrace}');
      throw e;
    }
  }

  // Get Messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chat room id from user ids (sorted to ensure it matches the id used when sending the message)
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String chatRoomId = userIds.join("_");

    // get messages from firestore
    return _firestore
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();

  }

}