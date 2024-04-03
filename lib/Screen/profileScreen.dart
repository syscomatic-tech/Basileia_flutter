import 'dart:convert';

import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:flutter/material.dart';
import 'package:basileia/RestAPI/model.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class ProfileScreen extends StatelessWidget {
  String usId;
  ProfileScreen({super.key, required this.usId});
  String bio = '';
  @override
  Widget build(BuildContext context) {
    var data = GetUserProfile(usId);
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
          } else {
            UsrProfile? usprofile;
            if (snapshot.hasData) {
              usprofile = snapshot.data;
              bio = "Some bio";
            } else {
              ErrorToast("Cant fetch data ");
              return const Scaffold(
                  body: Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())));
            }
            return Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Row(
                      children: [
                        arrowButton(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                        ),
                        const Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: poppins_semibold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: bordar,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                button_(
                                    onTap: () {},
                                    text: 'Friends',
                                    backGroundColor: primary_1,
                                    bordarColor: Colors.transparent,
                                    height: 40,
                                    width: 85),
                                button_(
                                    onTap: () {},
                                    text: 'My Activity',
                                    backGroundColor: Colors.transparent,
                                    bordarColor: bordar,
                                    height: 40,
                                    width: 94,
                                    textColor: bordar),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            usprofile!.profilePic.isEmpty
                                ? Profile(
                                    OutSidehight: 120,
                                    OutSidewidth: 120,
                                    InSideHight: 110,
                                    InsideWidth: 110,
                                    InSideRadius: 60,
                                    OutSideRadius: 60)
                                : ProfileImage(
                                    bimg: base64Decode(
                                        usprofile.profilePic.split(',').last),
                                    OutSidehight: 120,
                                    OutSidewidth: 120,
                                    InSideHight: 110,
                                    InsideWidth: 110,
                                    InSideRadius: 60,
                                    OutSideRadius: 60),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              usprofile!.name,
                              style: const TextStyle(
                                  fontSize: 16, fontFamily: poppins_semibold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 65, right: 65),
                              child: Text(
                                bio,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: poppins_regular,
                                    color: primaryTxt),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 65, right: 65),
                              child: Text(
                                bio,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: poppins_regular,
                                    color: primaryTxt),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                profileButton(
                                    onTap: () {},
                                    text: 'Location',
                                    ic: location_ic),
                                const SizedBox(
                                  width: 15,
                                ),
                                profileMassageButton(),
                                const SizedBox(
                                  width: 10,
                                ),
                                profileButton(
                                    onTap: () {},
                                    text: 'Church I attend',
                                    ic: institution_ic),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            statistic(
                              backGround: TabBG,
                              following: usprofile!.totFollowings.toString(),
                              POST: usprofile.totPosts.toString(),
                              followers: usprofile.totFollowers.toString(),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: usprofile.posts.length,
                              itemBuilder: (context, index) {
                                return profilePosts(
                                  post: usprofile!.posts[index],
                                  like: usprofile.posts[index].likes.length
                                      .toString(),
                                  caption: usprofile.posts[index].post_type > 0
                                      ? usprofile.posts[index].caption
                                      : usprofile.posts[index].file_content,
                                  content: usprofile.posts[index].post_type > 0
                                      ? usprofile.posts[index].file_content
                                      : null,
                                  comments: usprofile.posts[index].comments,
                                  share: 0.toString(),
                                  username: usprofile.name,
                                  time: usprofile.times[index],
                                );
                              },
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
        });
  }
}
