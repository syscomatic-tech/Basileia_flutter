import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/profileScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/controller.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  final menuTitle = [
    'Messages',
    'Group message',
    'Church Page',
    'Forums',
    'Groups',
    'Donation History',
    'Bible'
  ];
  final menuSubTitle = [
    'Message your friends',
    'Message your friends',
    'Message your friends',
    'See your recent activity',
    'Message your friends',
    'Checkout your previous donation history',
    'Bible',
  ];
  final menuCount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var followers = [''];
  var postID = "";
  ImagePick_1 imagePick_1 = ImagePick_1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          profile_1(
                            bimage: imagePick_1.imagePath.toString(),
                            outsideBorder: 55,
                            outsideBorderRedius: 30,
                            bordarColor: profileBorder,
                            insideBorder: 45,
                            insideBorderRedius: 30,
                            onPressed: () async {
                              Get.to(()=> ProfileScreen(usId: userId));
                              // await imagePick_1.pickImage();
                              // SocialClient scl_client = SocialClient();
                              // if (imagePick_1.imagePath.toString().isNotEmpty) {
                              //   SuccessToast("Updating pic please wait");
                              //   await scl_client.update_profile(userFullname,
                              //       ".", imagePick_1.imagePath.toString());
                              //   SuccessToast("Upload done");
                              // } else {
                              //   ErrorToast("Please select a valid image");
                              // }
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userFullname,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: poppins_semibold,
                                    fontSize: 16),
                              ),
                              Text(
                                userEmail,
                                style: const TextStyle(
                                    color: primaryTxt,
                                    fontFamily: poppins_regular,
                                    fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      listTielButton(onTap: () {Get.to(()=>ProfileScreen(usId: userId));})
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            statistic(
              backGround: primary_1,
              followers: userFollowers.toString(),
              following: userFollowings.length.toString(),
              POST: userPoststotal.toString(),
            ),
            ListView.builder(
              itemCount: menuTitle.length,
              itemBuilder: (context, index) {
                return menuItem(
                    title: menuTitle[index],
                    subtitle: menuSubTitle[index],
                    count: menuCount[index]);
              },
              shrinkWrap: true,
              primary: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: bordar,
            ),
            const SizedBox(
              height: 18,
            ),
            menuItem(
                title: 'Privacy Policy',
                subtitle: 'Protect your privacy',
                count: 0),
            const SizedBox(
              height: 10,
            ),
            menuButton(
                onTap: () {},
                bordarColor: primary,
                txtColor: primary,
                text: 'Switch To Church Profile'),
            const SizedBox(
              height: 15,
            ),
            menuButton(
                onTap: () {},
                bordarColor: menuItem_,
                txtColor: menuItem_,
                text: 'Log out'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
