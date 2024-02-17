import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService {
  //get Instance of FB store...
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get UserStream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send messages
  Future<void> sendMessage(String receiverId, message) async {
    //getCurrentUser
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    //create New Message
    Message newMessage = Message(
      senderEmail: currentUserEmail,
      senderId: currentUserId,
      timeStamp: timeStamp,
      message: message,
      receiverId: receiverId,
    );

    //construct Chatroom ID which store all messages as list type
    List<String> ids = [currentUserId, receiverId];

    ids.sort(); //sort the ids (this ensures this chat id is same for 2 users)
    String chatRoomId = ids.join('_');

    //add new message to db

    await _firestore
        .collection('Chat_Rooms')
        .doc(chatRoomId)
        .collection('Messages')
        .add(
          newMessage.toMap(),
        );
  }

  //getting message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    print(1);

    return _firestore
        .collection('Chat_Rooms')
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
