import 'dart:convert';

import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/menuScreen.dart';
import 'package:basileia/Screen/postOnFeed.dart';
import 'package:basileia/Screen/profileScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:flutter/material.dart';
import 'package:basileia/RestAPI/model.dart';
import 'package:get/get.dart';
import 'dart:async';

class HomeFeedController2 extends GetxController {
  List<Post>? posts = [];
  var scl_client = SocialClient();
  Future<List<Post>> call_posts() async {
    final postss = await scl_client.get_all_posts();
    return postss;
  }
}

class HomeFeedScreen2 extends GetView<HomeFeedController2> {
  final HomeFeedController2 controller = Get.put(HomeFeedController2());
  List<Widget> feeds = [];
  List<Post>? posts = [];
  var scl_client = SocialClient();

  @override
  Widget build(BuildContext context) {
    bool showFAB = MediaQuery.of(context).viewInsets.bottom != 0;
    var data = scl_client.get_all_posts();
    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
                body: Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())));
          } else {
            if (snapshot.hasData) {
              posts = snapshot.data;
            } else {
              print(snapshot);
              posts = [];
            }
            for (var post in posts!) {
              if (post.post_type < 2) {
                if (!post.file_content.toString().contains(
                    "https://api.zahedhasan.com/api/v1/uploads/users")) {
                  feeds.add(Feeds(context,
                      userName: post.usrName,
                      followers: post.followers.length.toString(),
                      likes: post.likes.length.toString(),
                      comments: post.comments.length.toString(),
                      postType: post.post_type,
                      content: post.file_content.toString(),
                      postID: post.id.toString(),
                      capt: post.caption,
                      post: post));
                }
              } else {
                // Audio and video feeds
              }
            }
            return Scaffold(
              floatingActionButton: Visibility(
                visible: !showFAB,
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => PostOnFeed());
                  },
                  backgroundColor: primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.34, right: 6.34),
                  child: Column(
                    children: [
                      Container(
                        height: 310,
                        decoration: const BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(22.64),
                                bottomRight: Radius.circular(22.64))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 37, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    appLogo,
                                    width: 56,
                                  ),
                                  Row(
                                    children: [
                                      userProfile.isEmpty
                                          ? Profile(
                                              onPressed: () {
                                                Get.to(() => ProfileScreen(
                                                    usId: userId));
                                              },
                                              OutSidehight: 47,
                                              OutSidewidth: 47,
                                              InSideHight: 38,
                                              InsideWidth: 38)
                                          : ProfileImage(
                                              onPressed: () {
                                                Get.to(() => ProfileScreen(
                                                    usId: userId));
                                              },
                                              OutSidehight: 47,
                                              OutSidewidth: 47,
                                              InSideHight: 38,
                                              InsideWidth: 38,
                                              bimg: userProfile),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.to(() => MenuScreen());
                                        },
                                        icon: Image.asset(menu),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 20, right: 220, left: 10),
                              child: Text(
                                'Wellcome,',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.46,
                                    color: Colors.white,
                                    fontFamily: poppins_semibold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 50),
                              child: Text(
                                'Consectetur adipiscing elit ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.6,
                                    color: Colors.white,
                                    fontFamily: poppins_regular),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            searchBar(),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 15, left: 250),
                            //   child: AdvanceFilterButton(onTap: () async {
                            //     var inboxscr = InboxScreen();
                            //     await inboxscr.GetUsers();
                            //     Get.to(() => inboxscr);
                            //   }),
                            // )
                          ],
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: feeds.length,
                          itemBuilder: (context, index) {
                            return feeds[index];
                          }),
                      InkWell(
                        onTap: () async {
                          Get.to(() => HomeFeedScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Load more feeds',
                              style: TextStyle(
                                color: fonts,
                                fontFamily: poppins_regular,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(Button_Next)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
