import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:basileia/Style/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../RestAPI/model.dart';
import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';
import '../Style/images.dart';

class CommentRepliesScreen extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController commentController = TextEditingController();
  final List<Replies> replies;
  final String commentId;
  final String postId;
  CommentRepliesScreen(
      {super.key,
      required this.replies,
      required this.commentId,
      required this.postId});
  final scl = SocialClient();
  late CommentRepliesController cmnt = CommentRepliesController(replies);
  @override
  Widget build(BuildContext context) {
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
                            'Comment Replies',
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
                            itemCount: cmnt.replies.value.length,
                            itemBuilder: (context, index) {
                              return Comments(
                                  profpic: "",
                                  user: cmnt.replies.value[index].usrname,
                                  content: cmnt.replies.value[index].content,
                                  ontap: () {
                                    ErrorToast("You cant reply to a reply");
                                  },
                                  like: 0.toString(),
                                  reply: cmnt.replies.value.length.toString(),
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
                    final out = await reply_comment(
                        commentController.text, postId, commentId);
                    cmnt.AddComment(Replies(
                      userId: userId,
                      id: commentId,
                      content: commentController.text,
                      usrname: userFullname,
                      time: "",
                    ));
                    SuccessToast(out);
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
