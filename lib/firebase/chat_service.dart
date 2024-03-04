import 'package:basileia/firebase/message.dart';
import 'package:basileia/RestAPI/RestClient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  var name = "";
  var email = "";
  var id = "";
  User({required this.name, required this.email, required this.id});
}

class Chatservice {
  // get instance of firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> senderMessage(String receiverId, message) async {
    // get current User Info
    final String currentUserId = userId;
    final String CurrName = userFullname;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
        senderId: currentUserId,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        senderEmail: CurrName);

    // to ensure uniqueness
    List<String> ids = [currentUserId, receiverId];

    ids.sort();
    String chatRoomId = ids.join('_');
    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  Stream<List<Map<String, dynamic>>> messagesStream(
      String senderId, String otherUserID) {
    List<String> ids = [senderId, otherUserID];
    ids.sort();
    String ChatRoomID = ids.join('_');
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(ChatRoomID)
        .collection('message')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => (doc.data())).toList();
    });
  }

  //get messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String senderId, String otherUserID) {
    List<String> ids = [senderId, otherUserID];
    ids.sort();
    String ChatRoomID = ids.join('_');

    var snapsots = _firestore
        .collection('chat_rooms')
        .doc(ChatRoomID)
        .collection('message');
    return snapsots.snapshots();

    // return snapsots.orderBy('timestamp', descending: false).snapshots();
  }
}
