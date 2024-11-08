import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:basileia/Screen/postOnFeed_1.dart';
import 'package:basileia/Style/images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "dart:io";
import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../Style/controller.dart';
import 'dart:io';

class PostOnFeed extends StatelessWidget {
  final MyTabsController controller = Get.put(MyTabsController());
  ImagePick _imagepick = Get.put(ImagePick());
  final TextEditingController _verseController = TextEditingController();

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
                  InkWell(
                    onTap: () {
                      _imagepick.clearImagePath();
                      Get.back();
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
                        if (_imagepick.imagePath.toString().isNotEmpty) {
                          Get.to(() => PostOnFeed_1());
                        } else if (_verseController.text
                            .toString()
                            .isNotEmpty) {
                          var outp = await scl_cl
                              .upload_verse(_verseController.text.toString());
                          SuccessToast(outp);
                          Get.to(() => HomeFeedScreen());
                        } else {
                          ErrorToast("No Post selected");
                        }
                      },
                      text: 'Next')
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
            Padding(
              padding: const EdgeInsets.only(right: 110),
              child: Container(
                width: 269,
                height: 51,
                decoration: BoxDecoration(
                    color: TabBG, borderRadius: BorderRadius.circular(30)),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(30),
                  labelColor: Colors.white,
                  unselectedLabelColor: textFi,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: primary),
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  controller: controller.tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Photos',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Videos',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Audio',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.maxFinite,
              height: 500,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => SizedBox(
                              width: MediaQuery.of(context).size.width * 0.92,
                              height: 211,
                              child: _imagepick.imagePath.isEmpty
                                  ? DottedBorder(
                                      radius: const Radius.circular(15),
                                      dashPattern: const [10, 10],
                                      strokeWidth: 2,
                                      borderType: BorderType.RRect,
                                      color: bordar,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            button(
                                                Height: 45,
                                                Width: 151,
                                                onTap: () async {
                                                  await _imagepick.pickImage();

                                                  SuccessToast("File chosen " +
                                                      _imagepick.imagePath
                                                          .toString());
                                                  pickFile();
                                                },
                                                text: 'Select Files'),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'Add Photos & Videos or Files',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: bordar),
                                            )
                                          ],
                                        ),
                                      ))
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.92,
                                      height: 211,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(File(_imagepick
                                                        .video_selected.value
                                                    ? _imagepick.thumbnail_pth
                                                        .toString()
                                                    : _imagepick.imagePath
                                                        .toString())))),
                                      ),
                                    ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Or',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: bordar),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textField(
                                controller: _verseController,
                                width: 290,
                                hight: 48,
                                lebelText: 'Paste Verse or Select Verse',
                                textfieldBg: TabBG),
                            const SizedBox(
                              width: 10,
                            ),
                            button(
                                Height: 45,
                                Width: 70,
                                onTap: () async {
                                  ClipboardData? clipboardData =
                                      await Clipboard.getData(
                                          Clipboard.kTextPlain);
                                  if (clipboardData != null) {
                                    // Assuming you have a TextEditingController for your TextField
                                    _verseController.text = clipboardData.text!;
                                  }
                                },
                                text: "Paste")
                          ],
                        )
                      ],
                    ),
                  ),
                  PostPhoto(context: context),
                  audioPost()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
