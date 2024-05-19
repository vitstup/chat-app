import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStrem() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String recieverId, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;

    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserID,
        senderEmail: currentUserEmail,
        recieverId: recieverId,
        message: message,
        timestamp: timestamp);
  
    List<String> ids = [currentUserID, recieverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    await _firestore
                  .collection("chat_rooms")
                  .doc(chatRoomID)
                  .collection("messages")
                  .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String usedID, otherUserID){
    List<String> ids = [usedID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
                    .collection("chat_rooms")
                    .doc(chatRoomID)
                    .collection("messages")
                    .orderBy("timestamp", descending: false)
                    .snapshots();
  }
}
