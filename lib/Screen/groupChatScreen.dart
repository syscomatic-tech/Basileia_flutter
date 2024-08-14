import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/CreateGroupScreen.dart';
import 'package:basileia/firebase/groupChat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/images.dart';
import '../Style/style.dart';

class GroupChatScreen extends StatelessWidget {
  bool isCurrentUser = true;
  final _groupbal = GroupChatService();
  final TextEditingController usecon = TextEditingController();
  final String Groupname;
  final String GroupId;
  GroupChatScreen({super.key,required this.Groupname,required this.GroupId});

  @override
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
              child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {

              var alignment =
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
              return Container(alignment: alignment,
              child: ChatBubble(message: 'message', isCurrentUser: true));
            },
          )),
          chatScreenTextField(
            controller: usecon,
              micOnTap: () {},
              sentOnTap: () async{
              if(usecon.text.isEmpty){
                return  SuccessToast('msg lek babachudi');
              }
                await  _groupbal.sendGroupMessage(userId,usecon.text);
              })
        ],
      ),
    );
  }
}
