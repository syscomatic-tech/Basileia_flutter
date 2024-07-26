import 'dart:convert';

import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/GroupCallScreen.dart';
import 'package:basileia/Screen/groupChatScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:basileia/firebase/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final String recevierEmail;
  final String receVierId;
  final String profilePic;

  ChatScreen(
      {super.key,
      required this.recevierEmail,
      required this.receVierId,
      required this.profilePic});

  final TextEditingController sentMsgController = TextEditingController();
  final MessageService messageService = MessageService();

  void sendMessage() async {
    if (sentMsgController.text.isNotEmpty) {
      await messageService.sendMessage(receVierId, sentMsgController.text);
      sentMsgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("the pic is");
    print(profilePic);
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
                      !profilePic.isNotEmpty
                          ? profileAvatar_1()
                          : profileAvatar(image: NetworkImage(profilePic)),
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
                      Get.to(GroupCallScreen());
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
          Expanded(child: _buildMessageList()),
          chatScreenTextField(
              micOnTap: () {
                Get.bottomSheet(chatBottomSheet(context: context));
              },
              sentOnTap: () {
                sendMessage();
              },
              controller: sentMsgController)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = userId;
    return StreamBuilder(
      stream: messageService.getMessages(receVierId, senderID),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == userId;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: ChatBubble(
          message: data["message"],
          isCurrentUser: isCurrentUser,
        ));
  }
}
