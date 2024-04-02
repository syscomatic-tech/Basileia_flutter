import 'package:basileia/Screen/homeFeedScreen.dart';
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

class PostOnFeed_1 extends StatelessWidget {
  final TabsController controller_1 = Get.put(TabsController());
  final ImagePick imagePick = Get.put(ImagePick());
  final _controller = TextEditingController();
  int count = 0;
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
                        SocialClient scl_cl = SocialClient();
                        count += 1;
                        if (count <= 1) {
                          SuccessToast("uploading post please wait");
                          if (_controller.text.isNotEmpty) {
                            await scl_cl.upload_post(
                                imagePick.imagePath.toString(),
                                _controller.text);
                          } else {
                            await scl_cl.upload_post(
                                imagePick.imagePath.toString(), "");
                          }
                          SuccessToast("post uploaded");

                          Get.to(() => HomeFeedScreen());
                        } else if (count <= 5) {
                          SuccessToast("be patient please");
                        } else {
                          SuccessToast(
                              "Post is being uploaded. Sit tight and wait please.");
                        }
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
                    SizedBox(
                      width: 380,
                      height: 66,
                      child: DottedBorder(
                          radius: const Radius.circular(5),
                          dashPattern: const [15, 10],
                          strokeWidth: 2,
                          borderType: BorderType.RRect,
                          color: bordar,
                          child: Center(
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 11),
                                    child: Container(
                                      width: 60,
                                      height: 46,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(File(imagePick
                                                  .imagePath
                                                  .toString())),
                                              fit: BoxFit.fill),
                                          color: ContainerBG,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 280,
                                    height: 46,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        imagePick.imagePath
                                            .toString()
                                            .split("/")
                                            .last,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: textFi,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: poppins_regular),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Post In :',
                          style: TextStyle(
                              fontFamily: poppins_regular,
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        textField(
                            width: 256,
                            hight: 48,
                            lebelText: 'My Profile',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: InkWell(
                                  onTap: () {},
                                  child: Image.asset(Downarrow_ic)),
                            ),
                            textfieldBg: TabBG),
                      ],
                    )
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
