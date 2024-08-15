import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/profileScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../RestAPI/model.dart';
import '../Style/controller.dart';

class MenuScreen extends StatelessWidget {
  final UserId;
  MenuScreen({super.key, required this.UserId});
  final menuTitle = [
    'Messages',
    'Group message',
    'Church Page',
    'Forums',
    'Groups',
    'Donation History',
  ];
  final menuSubTitle = [
    'Message your friends',
    'Message your friends',
    'Message your friends',
    'See your recent activity',
    'Message your friends',
    'Checkout your previous donation history',
  ];
  final menuCount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var followers = [''];
  var postID = "";
  ImagePick_1 imagePick_1 = ImagePick_1();
  @override
  Widget build(BuildContext context) {
    var data = GetUserProfile(UserId);
    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<UsrProfile> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
                body: Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())));
          }
          UsrProfile? usprofile;
          if (snapshot.hasData) {
            usprofile = snapshot.data;
          } else {
            ErrorToast("Cant fetch data ");
            return const Scaffold(
                body: Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())));
          }
          return Column(
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
                            usprofile!.profilePic.isEmpty
                                ? Profile(
                                    OutSidehight: 120,
                                    OutSidewidth: 120,
                                    InSideHight: 110,
                                    InsideWidth: 110,
                                    InSideRadius: 60,
                                    OutSideRadius: 60)
                                : profile_1(
                                    bimage: usprofile!.profilePic.toString(),
                                    outsideBorder: 55,
                                    outsideBorderRedius: 30,
                                    bordarColor: primary,
                                    insideBorder: 45,
                                    insideBorderRedius: 30,
                                    onPressed: () {
                                      Get.to(() => ProfileScreen(usId: userId));
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
                                  usprofile!.name.toString(),
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
                        listTielButton(onTap: () {
                          Get.to(() => ProfileScreen(usId: userId));
                        })
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              statistic(
                backGround: TabBG,
                following: usprofile!.totFollowings.toString(),
                POST: usprofile.totPosts.toString(),
                followers: usprofile.totFollowers.toString(),
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
          );
        });
  }
}
