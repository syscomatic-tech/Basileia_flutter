import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:basileia/Style/videoplayer2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../RestAPI/RestClient.dart';
import '../Screen/commentScreen.dart';
import '../Screen/profileScreen.dart';
import 'likeiconwidget.dart';

class videoPlayer extends StatelessWidget {
  final String userName;
  final String followers;
  final String likes;
  final String comments;
  final String postID = "";
  final String capt = "";
  final String VideoUrl;
  var post;
  videoPlayer(
      {super.key,
      required this.userName,
      required this.followers,
      required this.likes,
      required this.comments,
      required this.VideoUrl,
      required this.post});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  post.profilePic.isEmpty
                      ? Profile(
                          onPressed: () {
                            Get.to(() => ProfileScreen(usId: post.userID));
                          },
                          OutSidehight: 47,
                          OutSidewidth: 47,
                          InSideHight: 38,
                          InsideWidth: 38)
                      : ProfileImage(
                          onPressed: () {
                            Get.to(() => ProfileScreen(usId: post.userID));
                          },
                          OutSidehight: 47,
                          OutSidewidth: 47,
                          InSideHight: 38,
                          InsideWidth: 38,
                          bimg: post.profilePic),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        userName!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16.3,
                            fontFamily: poppins_regular,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${followers.toString()} Followers',
                        style: const TextStyle(
                            fontSize: 10.87,
                            color: textFi,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
              if (post.userID != userId)
                FeedFollowButton(
                  fallaw: post.followers.contains(userId) ? "t" : "f",
                  onTap: () async {
                    var outp = await Follow_user(post.userID);
                    SuccessToast(outp);
                  },
                )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(capt),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                      child: CustomVideoPlayer(url: VideoUrl)),
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LikeWidget(likes: post.likes, postID: postID),
              FeedIcButton(
                  onTap: () {
                    Get.to(() => CommentScreen(
                          post: post!,
                        ));
                  },
                  ic: Comment_ic,
                  text: '${comments.toString()} Comments'),
              FeedIcButton(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm'),
                          content:
                              Text('Are you sure you want to share this post?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Share'),
                              onPressed: () async {
                                print('Post shared');
                                var outp = await Share_post(postID);
                                SuccessToast(outp);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  ic: Share_ic,
                  text: 'Share this post'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: bordar,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
