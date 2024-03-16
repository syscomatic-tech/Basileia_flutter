import 'package:basileia/RestAPI/RestClient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../RestAPI/social.dart';
import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class CommentScreen extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  String PostId = '';
  @override
  Widget build(BuildContext context) {
    var scl = SocialClient();
    void sendComment()async{
      if(commentController.text.isNotEmpty){
        await scl.comment_post(commentController.text,PostId);
        //print(PostId);
        commentController.clear();
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Column(
                children:[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: Row(
                      children: [
                        arrowButton(),
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
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Comments();
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
                  Context: context, onTap: () {sendComment();},
                controller: commentController,
              )
            ],
          ),
        ],
      ),
    );
  }
}
