import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:basileia/Style/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../RestAPI/social.dart';
import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';
import '../Style/images.dart';

class CommentScreen extends StatefulWidget {
  final Post post;
  CommentScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentController = TextEditingController();
  late final PostCommentController cmnt;
  final SocialClient scl = SocialClient();

  @override
  void initState() {
    super.initState();
    cmnt =
        PostCommentController(widget.post); // Use the post passed to the widget
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  // Your UI code here...
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: cmnt.post.value.comments.length,
                            itemBuilder: (context, index) {
                              return Comments(
                                  user: cmnt.post.value.comments[index].usrname,
                                  content:
                                      cmnt.post.value.comments[index].content,
                                  like:
                                      "0", // Assuming these are placeholders for now
                                  reply: "0",
                                  share: "0");
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  commentTextFiled(
                    onTap: () async {
                      if (commentController.text.isNotEmpty) {
                        final bool out = await scl.comment_post(
                            commentController.text, widget.post.id);
                        if (out) {
                          cmnt.AddComment(Comment(
                              userId: "userId", // Replace with actual user ID
                              id: widget.post.id,
                              content: commentController.text,
                              usrname:
                                  "userFullname")); // Replace with actual username
                          SuccessToast("Comment Added");
                        } else {
                          ErrorToast("Something Went wrong");
                        }
                        commentController.clear(); // Clear the text field
                      } else {
                        ErrorToast("Please enter a comment");
                      }
                    },
                    controller: commentController,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
