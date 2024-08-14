import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/groupChatScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/firebase/groupChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../Style/fonts.dart';
import '../Style/images.dart';
import '../Style/style.dart';

class GroupMassage extends StatelessWidget {
  final _groupsev = GroupChatService();
  final String userId; // Pass userId here

  GroupMassage({required this.userId});

  @override
  Widget build(BuildContext context) {
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
                    'Groups',
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
                        'All Messages ',
                        style: TextStyle(
                            fontSize: 14, fontFamily: poppins_semibold),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _groupsev.getUserGroups(userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No groups found.'));
                          }

                          var groups = snapshot.data!.docs;

                          return ListView.builder(
                            itemCount: groups.length,
                            itemBuilder: (BuildContext context, int index) {
                              var group = groups[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    extentRatio: 0.30,
                                    motion: const ScrollMotion(),
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Add your delete action here
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 23, left: 10),
                                          child: Container(
                                            height: 80,
                                            width: 85,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Image.asset(delete),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: chatItem(
                                    image: null,
                                    title: group['groupName'].toString(),
                                    subTitle: 'not ',
                                    msgCount: 0,
                                    onTap: () {
                                      Get.to(() => GroupChatScreen(Groupname:group['groupName'].toString() ,GroupId: group['GroupId'].toString(),));
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
