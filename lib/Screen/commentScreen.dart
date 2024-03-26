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

class CommentScreen extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController commentController = TextEditingController();
  Post post;
  CommentScreen({super.key, required this.post});
  var scl = SocialClient();
  late PostCommentController cmnt = PostCommentController(post);
  @override
  Widget build(BuildContext context) {
    var cumments = [""];
    for (var commnt in post.comments) {
      cumments.add(commnt.content);
    }
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => HomeFeedScreen());
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(arrow_ic),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Text(
                            'Comments',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: poppins_semibold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: bordar,
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() => ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: cmnt.post.value.comments.length,
                            itemBuilder: (context, index) {
                              return Comments(
                                  user: cmnt.post.value.comments[index].usrname,
                                  content:
                                      cmnt.post.value.comments[index].content,
                                  like: 0.toString(),
                                  reply: 0.toString(),
                                  share: 0.toString());
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              commentTextFiled(
                focusNode: _focusNode,
                Context: context,
                onTap: () async {
                  if (commentController.text.isNotEmpty) {
                    final out =
                        await scl.comment_post(commentController.text, post.id);
                    cmnt.AddComment(Comment(
                        userId: userId,
                        id: post.id,
                        content: commentController.text,
                        usrname: userFullname));
                    if (out) {
                      SuccessToast("Comment Added");
                    } else {
                      ErrorToast("Something Went wrong");
                    }
                  } else {
                    ErrorToast("Please enter a comment");
                  }
                  commentController.clear();
                  _focusNode.unfocus();
                },
                controller: commentController,
              )
            ],
          ),
        ],
      ),
    );
  }
}
