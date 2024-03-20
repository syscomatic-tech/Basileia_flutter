
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/colors.dart';
import '../Style/controller.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class PostOnFeed_1 extends StatelessWidget {
  const PostOnFeed_1({super.key,});
  @override
  Widget build(BuildContext context) {
  final TabsController controller_1 = Get.put(TabsController());
  final ImagePick imagePick = Get.put(ImagePick());
  return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  arrowButton(),
                  const Text(
                    'New Post',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: poppins_semibold),
                  ),
                  button(Width:72, Height:45, onTap:() {Get.to(()=>PostOnFeed_1());}, text:'Post'),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: bordar,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.maxFinite,
              height: 500,
              child: postPhoto_1(),
            )
          ],
        ),
      ),
    );
  }
}
