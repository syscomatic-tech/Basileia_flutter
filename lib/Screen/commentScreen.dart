import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../RestAPI/social.dart';
import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';
import '../Style/images.dart';

class CommentScreen extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  late Post post;
  CommentScreen({super.key, required this.post});
  var scl = SocialClient();
  Future<void> sendComment() async {
    if (commentController.text.isNotEmpty) {
      await scl.comment_post(commentController.text, post.id);
      //print(PostId);
      commentController.clear();
    }
  }

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
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) {
                          return Comments(
                              user: post.comments[index].usrname,
                              content: post.comments[index].content,
                              like: 0.toString(),
                              reply: 0.toString(),
                              share: 0.toString());
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
                Context: context,
                onTap: () async {
                  await sendComment();
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
