import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:basileia/Style/controller.dart";
import "package:basileia/Style/style.dart";
import "package:basileia/Style/images.dart";
import 'package:basileia/Screen/homeFeedScreen.dart';
import "package:basileia/RestAPI/RestClient.dart";

class LikeWidget extends StatelessWidget {
  var likes = [""];
  var postID = "";
  LikeWidget({super.key, required this.likes, required this.postID});
  final PostLikeController postController =
      Get.put(PostLikeController()); // Create an instance of PostController

  @override
  Widget build(BuildContext context) {
    return Obx(() => FeedIcButton(
          onTap: () async {
            postController
                .toggleLike(); // Call toggleLike when button is tapped
            // If there are other actions like navigating screens, you can perform them here
            // For example, after liking a post, you want to show a success message:
            SocialClient scl_cl = SocialClient();
            await scl_cl.likePost(postID);
            SuccessToast("Successfully liked the post");
            // And possibly navigate or perform other UI updates:
            Get.to(() => HomeFeedScreen());
          },
          ic: postController.isLiked.value
              ? Liked_ic
              : likes.contains(userId)
                  ? Liked_ic
                  : Like_ic, // Use Obx here to listen to changes
          text:
              '${likes.length.toString()} Likes', // Assuming 'likes' is a variable you have for the number of likes
          clr: Colors.red,
        ));
  }
}
