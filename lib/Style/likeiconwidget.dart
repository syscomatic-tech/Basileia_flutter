import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:basileia/Style/controller.dart";
import "package:basileia/Style/style.dart";
import "package:basileia/Style/images.dart";
import "package:basileia/RestAPI/RestClient.dart";

class LikeWidget extends StatelessWidget {
  var likes = [""];
  var postID = "";

  LikeWidget({super.key, required this.likes, required this.postID});
  final PostLikeController postController = PostLikeController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => FeedIcButton(
          onTap: () async {
            postController
                .toggleLike();
            SocialClient scl_cl = SocialClient();
            await scl_cl.likePost(postID);
            SuccessToast("Successfully liked the post");
          },
          ic: postController.isLiked.value
              ? Liked_ic
              : likes.contains(userId)
                  ? Liked_ic
                  : Like_ic,
          text:
              '${likes.length.toString()} Likes',
          clr: Colors.red,
        ));
  }
}
