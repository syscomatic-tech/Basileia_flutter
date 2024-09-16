import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:basileia/Screen/forumsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Style/images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import '../Style/colors.dart';
import '../Style/controller.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class ForumsUpload extends StatelessWidget {
  final TabsController controller_1 = Get.put(TabsController());
  final _controller = TextEditingController();
  final Baracontroller = TextEditingController();
  final drop_item = dropdownItem();
  @override
  Widget build(BuildContext context) {
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
                  button(
                      Width: 72,
                      Height: 45,
                      onTap: () async {
                        if (_controller.text.isNotEmpty) {
                          SocialClient scl_cl = SocialClient();
                          await uploadForumPost(
                              _controller.text,
                              drop_item.controller.selectedItem.value,
                              Baracontroller.text.toString().split(","));
                          SuccessToast("post uploaded");
                        } else {
                          SuccessToast("please enter something");
                        }

                        Get.to(() => ForumsScreen());
                      },
                      text: 'Post'),
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 273,
                      width: 373,
                      decoration: BoxDecoration(
                          color: TabBG,
                          borderRadius: BorderRadius.circular(19)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: _controller,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'What’s On Your Mind',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: poppins_regular,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(
                        lebelText: 'Some Tags like this pizza,burger,chick',
                        width: MediaQuery.of(context).size.width * 0.90,
                        textfieldBg: Colors.white,
                        controller: Baracontroller),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Post In :',
                          style: TextStyle(
                              fontFamily: poppins_regular,
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    drop_item
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
