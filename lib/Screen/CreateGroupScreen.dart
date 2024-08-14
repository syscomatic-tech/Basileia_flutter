import 'package:basileia/Screen/createGroup2.0bottomSheet.dart';
import 'package:basileia/Style/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../RestAPI/RestClient.dart';
import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/images.dart';
import '../Style/style.dart';
import '../firebase/chat_service.dart';

class CreateGroupScreen extends StatelessWidget {
  CreateGroupScreen({super.key});

  final SocialClient sex_client = SocialClient();

  List<User> UserList = [];

  Future<bool> GetUser() async {
    var users = await sex_client.get_users();
    if (users is List) {
      for (var user in users) {
        UserList.add(User(
          name: user['firstName'] + " " + user['lastName'],
          id: user["_id"],
          email: user["email"],
          profpic:
              user.containsKey("profilePicture") ? user["profilePicture"] : "",
        ));
      }
      return true;
    }
    return false;
  }

  final name = [
    'alexanderoucaocaocouascb',
    'Abraham',
    'Adi',
  ];

  List<ToggleController> memberList = [];
  String useid = '';

  @override
  Widget build(BuildContext context) {
    print(UserList);
    for (var user in UserList) {
      memberList.add(ToggleController(user.id.obs, user.name.obs));
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                List<String> grp_members = [];
                for (var member in memberList) {
                  if (member.showImage.value) {
                    grp_members.add(member.userId.value);
                  }
                }
                return createGroupBottomSheet(
                  userids: grp_members,
                );
              });
        },
        backgroundColor: primary,
        label: const Text(
          'Create group',
          style: TextStyle(color: Colors.white, fontFamily: poppins_regular),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 400,
                  color: primary,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 45, left: 15),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(arrowLeft)),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Add New Group',
                              style: TextStyle(
                                  fontFamily: poppins_regular,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 100,
                        child: Obx(() => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: memberList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (memberList[index].showImage.value) {
                                  return AddgroupList(
                                      text: memberList[index].name.value,
                                      onTab: () {});
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            )),
                      )
                    ],
                  )),
            ],
          ),
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView.builder(
                itemCount: UserList.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return createGroup(
                      toggleController: memberList[index],
                      title: UserList[index].name,
                      subTitle: UserList[index].email,
                      image: UserList[index].profpic.isNotEmpty
                          ? NetworkImage(UserList[index].profpic)
                          : null);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
