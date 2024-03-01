import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/groupChatScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:basileia/firebase/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class ChatScreen extends StatelessWidget {
  final SocialClient sex_client = SocialClient();
  final String recevierEmail;
  final String receVierId;
  ChatScreen(
      {super.key, required this.recevierEmail, required this.receVierId});
  final TextEditingController sentMsgController = TextEditingController();
  final Chatservice _chatservice = Chatservice();
  List<User> UserList = [];

  void SendMessage() async {
    if (sentMsgController.text.isNotEmpty) {
      await _chatservice.senderMessage(receVierId, sentMsgController.text);
      sentMsgController.clear();
    }
  }

  void GetUsers() async {
    final users = await sex_client.get_users();

    if (users is List) {
      for (var user in users) {
        UserList.add(User(
            name: user['firstName'] + " " + user["lastName"],
            id: user["id"],
            email: user["email"]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    GetUsers();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 116,
            decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(arrowLeft)),
                      const SizedBox(
                        width: 20,
                      ),
                      profileAvatar_1(),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recevierEmail,
                              style: const TextStyle(
                                  fontFamily: poppins_regular,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Online',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontFamily: poppins_regular),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(GroupChatScreen());
                    },
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildMessageList(),
          ),
          chatScreenTextField(
              micOnTap: () {
                Get.bottomSheet(chatBottomSheet(context: context));
              },
              sentOnTap: () {
                SendMessage();
              },
              controller: sentMsgController)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatservice.getMessages(userId, receVierId),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return const Text('Error');
          }
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Text('Loading....');
          }
          return ListView(
              children: snapShot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(
      data["message"],
    );
  }
}
