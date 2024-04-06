import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/firebase/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  var name = "";
  var email = "";
  var id = "";
  var profpic = "";
  User(
      {required this.name,
      required this.email,
      required this.id,
      required this.profpic});
}

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// send message
  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = userId;
    final String currentUserEmail = userFullname;
    final Timestamp timestamp = Timestamp.now();

    Message NewMessage = Message(
        senderID: userId,
        senderEmail: userFullname,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);
    List<String> ids = [userId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(NewMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
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
