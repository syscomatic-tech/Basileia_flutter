
import 'package:basileia/Screen/CreateGroupScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/images.dart';
import '../Style/style.dart';

class GroupChatScreen extends StatelessWidget {  @override
  Widget build(BuildContext context) {
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
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Group Name',
                              style: TextStyle(
                                  fontFamily: poppins_regular,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
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
                  const Icon(
                    Icons.call,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: GroupedListView<Message, DateTime>(
                reverse: true,
                shrinkWrap: true,
                elements: [
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: true),
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: true),
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: false),
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: true),
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: false),
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: false),
                  Message(
                      text: 'Hi, how are you? and well, happy belated birthday!',
                      date: DateTime.now(),
                      isSentByMe: true),
                ],
                groupBy: (message) => DateTime(2024),
                groupHeaderBuilder: (Message message) => const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Today',
                        style:
                        TextStyle(color: primaryTxt, fontFamily: poppins_regular),
                      )),
                ),
                itemBuilder: (context, Message message) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Align(
                    alignment: message.isSentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child:message.isSentByMe? Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                          color: message.isSentByMe ? primary : chatContent,
                          borderRadius: message.isSentByMe
                              ? const BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(4))
                              : const BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              bottomLeft: Radius.circular(4))),
                      child: Text(
                        message.text,
                        style: TextStyle(
                            color: message.isSentByMe ? Colors.white : chatTxtColor,
                            fontSize: 16),
                      ),
                    ): Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: profileAvatar_1(),
                        ),
                        const SizedBox(width: 4,),
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration:const  BoxDecoration(
                              color: chatContent,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(4))),
                          child: Text(
                            message.text,
                            style: const TextStyle(
                                color: chatTxtColor,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          chatScreenTextField(micOnTap: (){},sentOnTap: (){
            Get.to(()=>CreateGroupScreen());
          })
        ],
      ),
    );
  }
}
