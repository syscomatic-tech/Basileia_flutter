import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/CreateGroupScreen.dart';
import 'package:basileia/Screen/GroupMassage.dart';
import 'package:basileia/firebase/groupChat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/style.dart';

class createGroupBottomSheet extends StatelessWidget {
  final List<String> userids;
   createGroupBottomSheet({super.key, required this.userids});
  final TextEditingController groupcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 250,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: textField(
                controller: groupcon,
                  suffixIcon: null,
                  lebelText: 'Group name',
                  width: MediaQuery.of(context).size.width * 0.70),
            ),
            button(
                onTap: () async{
                  final _grpser = GroupChatService();
                  if(groupcon==null){
                    return SuccessToast('Group name is null');
                  }
                  await _grpser.createGroup(groupcon.text, userids);
                  Get.to(()=>GroupMassage(userId: userId,));
                },
                text: "Create Group",
                Width: MediaQuery.of(context).size.width * 0.70,
                Height: 50)
          ],
        ),
      ),
    );
  }
}
