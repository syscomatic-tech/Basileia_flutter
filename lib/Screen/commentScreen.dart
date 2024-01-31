import 'package:basileia/Style/images.dart';
import 'package:flutter/material.dart';
import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class CommentScreen extends StatelessWidget {
 final comments = [
   Comments(),
   Comments_1(),
   Comments_1(),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
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
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return comments[index];
                    },
                  ),
                  InkWell(onTap: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Load more comments',style: TextStyle(color: primaryTxt,fontFamily: poppins_regular),),
                        const SizedBox(width: 10,),
                        Image.asset(Button_Next)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
