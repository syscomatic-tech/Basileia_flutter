import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final Timestamp timestamp;
  final String message;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.senderEmail
});
  Map<String,dynamic>toMap(){
    return {
      'senderId':senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message':message,
      'timestamp':timestamp,
    };
  }
}