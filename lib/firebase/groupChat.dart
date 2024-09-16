import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class GroupChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _currentGroupId; // Store the current group ID


  // Create a new group and set it as the current group
  Future<void> createGroup(String groupName, List<String> memberIds) async {
    final groupId = Uuid().v1();

    final groupChatRoom = GroupChatRoom(
      GroupId: groupId,
      groupName: groupName,
      memberIds: memberIds,
    );
    await _firestore.collection('Groups').doc(groupId).set(groupChatRoom.toMap());
    _currentGroupId = groupId;
  }

  void setCurrentGroup(String groupId) {
    _currentGroupId = groupId;
  }


  // Send a message to the current group
  Future<void> sendGroupMessage(String senderId, String message) async {
    if (_currentGroupId == null) {
      throw Exception('No group selected');
    }

    final messageId = Uuid().v1();

    try {
      await _firestore
          .collection('Groups')
          .doc(_currentGroupId!)
          .collection('Messages')
          .doc(messageId)
          .set({
        'messageId': messageId,
        'senderId': senderId,
        'message': message,
        'sentAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Failed to send message: $e');
    }
  }

  // Fetch groups where the current user is a member
  Stream<QuerySnapshot> getUserGroups(String userId) {
    return _firestore
        .collection('Groups')
        .where('memberIds', arrayContains: userId)
        .snapshots();
  }

  // Fetch messages for the current group
  Stream<QuerySnapshot> getGroupMessages(String groupId) {
    return _firestore
        .collection('Groups')
        .doc(groupId)
        .collection('Messages')
        .orderBy('sentAt', descending: true)
        .snapshots();
  }
}

class GroupChatRoom {
  GroupChatRoom({
    required this.GroupId,
    required this.groupName,
    required this.memberIds,
  });

  final String GroupId;
  final String groupName;
  final List<String> memberIds;

  Map<String, dynamic> toMap() {
    return {
      'GroupId': GroupId,
      'groupName': groupName,
      'memberIds': memberIds,
    };
  }
}
