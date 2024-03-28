import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/chatScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../firebase/chat_service.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({
    super.key,
  });
  final SocialClient sex_client = SocialClient();
  List<User> UserList = [];
  Future<bool> GetUsers() async {
    var users = await sex_client.get_users();
    if (users is List) {
      for (var user in users) {
        UserList.add(
            User(
            name: user['firstName'] + " " + user['lastName'],
            id: user["_id"],
            email: user["email"]));
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print(UserList);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                color: primary,
                child: const Center(
                  child: Text(
                    'Inbox',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: poppins_semibold),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inboxTopItem(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'All Message ',
                        style: TextStyle(
                            fontSize: 14, fontFamily: poppins_semibold),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: UserList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Slidable(
                                  endActionPane: ActionPane(
                                      extentRatio: 0.30,
                                      motion: const ScrollMotion(),
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 23, left: 10),
                                            child: Container(
                                              height: 80,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.asset(delete),
                                            ),
                                          ),
                                        )
                                      ]),
                                  child: chatItem(
                                      title: UserList[index].name,
                                      subTitle: UserList[index].email,
                                      msgCount: 0,
                                      onTap: () {
                                        Get.to(() => ChatScreen(
                                              recevierEmail:
                                                  UserList[index].name,
                                              receVierId: UserList[index].id,
                                            ));
                                      })),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
