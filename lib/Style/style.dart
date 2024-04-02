import 'dart:io';
import 'dart:ui';

import 'package:basileia/Screen/commentScreen.dart';
import 'package:basileia/RestAPI/model.dart';
import 'package:basileia/Screen/forumsScreen.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:basileia/Screen/profileScreen.dart';
import 'package:basileia/Screen/questionDetailsScreen.dart';
import 'package:basileia/Style/likeiconwidget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:readmore/readmore.dart';
import 'package:basileia/Screen/inboxScreen.dart';
import '../RestAPI/RestClient.dart';
import '../Screen/chatScreen.dart';
import '../Screen/inboxScreen.dart';
import 'colors.dart';
import 'controller.dart';
import 'fonts.dart';
import 'images.dart';

final ImagePick _imagepick = Get.put(ImagePick());

Widget Basic_Button({
  onTap,
  String? text,
}) {
  return SizedBox(
    height: 44.13,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: bordar))),
        onPressed: onTap,
        child: Text(
          text!,
          style: const TextStyle(fontSize: 12.75, color: Colors.black),
        )),
  );
}

Widget Primary_Button(
    {onTap,
    String? text,
    double? Width,
    Color? backgroundColor,
    Color? textColor}) {
  return SizedBox(
    height: 48,
    width: Width,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onTap,
        child: Text(
          text!,
          style: TextStyle(fontSize: 12.75, color: textColor ?? Colors.white),
        )),
  );
}

Widget textField(
    {double? width,
    double? hight,
    String? lebelText,
    suffixIcon,
    Color? textfieldBg,
    controller,
    bool? obscureText}) {
  return Container(
    width: width,
    height: hight,
    decoration: BoxDecoration(
        color: textfieldBg,
        border: Border.all(
          color: bordar,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 10),
      child: TextField(
        obscureText: obscureText ?? false,
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          hintText: lebelText,
          hintStyle: const TextStyle(
              fontSize: 14, color: textFi, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget ic_Button(
    {VoidCallback? onTap, String? text, icon, double? hight, double? width}) {
  return SizedBox(
    height: hight,
    width: width,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: bordar))),
      onPressed: onTap,
      label: Text(
        text!,
        style: const TextStyle(fontSize: 12.75, color: Colors.black),
      ),
      icon: icon,
    ),
  );
}

Widget OtpField({controller}) {
  final defaultPinTheme = PinTheme(
      width: 58,
      height: 46,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: bordar),
          borderRadius: BorderRadius.circular(10)));
  return Pinput(
    controller: controller,
    length: 4,
    defaultPinTheme: defaultPinTheme,
    focusedPinTheme: defaultPinTheme,
  );
}

Widget Profile(
    {VoidCallback? onPressed,
    double? OutSidehight,
    double? OutSidewidth,
    double? InSideHight,
    double? InsideWidth,
    double? InSideRadius,
    double? OutSideRadius,
    Color? bordarColor}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: OutSidehight,
      width: OutSidewidth,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(OutSideRadius ?? 30),
          border: Border.all(color: bordarColor ?? profileBorder, width: 1.8)),
      child: Center(
        child: Container(
          height: InSideHight,
          width: InsideWidth,
          decoration: BoxDecoration(
            color: bordar,
            borderRadius: BorderRadius.circular(InSideRadius ?? 30),
          ),
        ),
      ),
    ),
  );
}

Widget searchBar() {
  return Container(
    height: 43.76,
    width: 354.28,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 2),
      child: TextField(
        style: TextStyle(fontSize: 13.79),
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: textFi,
          ),
          border: InputBorder.none,
          hintText: 'Search friends',
          hintStyle: TextStyle(
            color: textFi,
            fontSize: 13.79,
            fontFamily: poppins_regular,
          ),
        ),
      ),
    ),
  );
}

Widget AdvanceFilterButton({onTap}) {
  return InkWell(
    onTap: onTap,
    child: const Text(
      'Advance Filter',
      style: TextStyle(
        fontSize: 13.79,
        color: Colors.white,
        fontFamily: poppins_regular,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white,
      ),
    ),
  );
}

Widget FeedIcButton({onTap, ic, text, clr}) {
  return InkWell(
    splashColor: clr,
    onTap: onTap,
    child: Row(
      children: [
        Image.asset(ic),
        const SizedBox(
          width: 3,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 11.7, color: Colors.black, fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

class FeedFollowButton extends StatelessWidget {
  final VoidCallback onTap;
  FeedFollowButton({super.key, required this.onTap, required this.fallaw});
  late String fallaw;
  final FollowController followController = FollowController();
  @override
  Widget build(BuildContext context) {
    if (fallaw == "t") {
      followController.toggleFollow();
    }
    return InkWell(
        onTap: () {
          onTap.call();
          followController.toggleFollow();
        },
        child: Container(
            height: 30.8,
            width: 86.05,
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(20)),
            child: Obx(() => Padding(
                  padding: const EdgeInsets.only(right: 10, left: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!followController.isFollowing.value)
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        followController.isFollowing.value
                            ? 'Unfollow'
                            : 'Follow',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      )
                    ],
                  ),
                ))));
  }
}

Widget Feeds(
  BuildContext context, {
  String? userName,
  String? followers,
  String? likes,
  String? comments,
  String postID = "",
  String capt = "",
  postType,
  content,
  post,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Profile(
                    onPressed: () {
                      Get.to(() => ProfileScreen(usId: post.userID));
                    },
                    OutSidehight: 47,
                    OutSidewidth: 47,
                    InSideHight: 38,
                    InsideWidth: 38),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      userName!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16.3,
                          fontFamily: poppins_regular,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${followers.toString()} Followers',
                      style: const TextStyle(
                          fontSize: 10.87,
                          color: textFi,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
            if (post.userID != userId)
              FeedFollowButton(
                fallaw: post.followers.contains(userId) ? "t" : "f",
                onTap: () async {
                  var outp = await Follow_user(post.userID);
                  SuccessToast(outp);
                },
              )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(capt),
                postType == 0
                    ? Text(
                        content.toString(),
                        textAlign: TextAlign.left,
                      )
                    : Image.network(content),
              ],
            )),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LikeWidget(likes: post.likes, postID: postID),
            FeedIcButton(
                onTap: () {
                  Get.to(() => CommentScreen(
                        post: post!,
                      ));
                },
                ic: Comment_ic,
                text: '${comments.toString()} Comments'),
            FeedIcButton(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm'),
                        content:
                            Text('Are you sure you want to share this post?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Share'),
                            onPressed: () async {
                              print('Post shared');
                              var outp = await Share_post(postID);
                              SuccessToast(outp);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                ic: Share_ic,
                text: 'Share this post'),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: bordar,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

Widget AudioFeeds({
  String? username,
  String? followers,
  content,
  postType,
  String? like,
  String? comment,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Profile(
                      onPressed: () {},
                      OutSidewidth: 47,
                      OutSidehight: 47,
                      InsideWidth: 38,
                      InSideHight: 38),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'William Grace',
                        style: TextStyle(
                            fontSize: 16.3,
                            fontFamily: poppins_regular,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '1,5K Follwoers',
                        style: TextStyle(
                            fontSize: 10.87,
                            color: textFi,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 58,
            decoration: BoxDecoration(
                color: ContainerBG, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.play_arrow,
                    color: ContainerBG,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(soundWave)
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FeedIcButton(onTap: () {}, ic: Like_ic, text: '120' 'Likes'),
              FeedIcButton(onTap: () {}, ic: Comment_ic, text: '6 ' 'Comments'),
              FeedIcButton(onTap: () {}, ic: Share_ic, text: 'Share this post'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: bordar,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

Widget arrowButton() {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(10)),
      child: Image.asset(arrow_ic),
    ),
  );
}

Widget button({double? Width, double? Height, onTap, String? text}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Width,
      height: Height,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
          child: Text(
        text!,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: poppins_regular,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      )),
    ),
  );
}

Widget PostPhoto({onTap, textController, onPasteButtonTap, context}) {
  return Padding(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            button(
                                Height: 45,
                                Width: 151,
                                onTap: onTap,
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
                      width: MediaQuery.of(context).size.width * 0.92,
                      height: 211,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(
                                    File(_imagepick.imagePath.toString())))),
                      ),
                    ),
            )),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Or',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: bordar),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textField(
                controller: textController,
                width: 290,
                hight: 48,
                lebelText: 'Paste Verse or Select Verse',
                textfieldBg: TabBG),
            const SizedBox(
              width: 10,
            ),
            button(
                Height: 45, Width: 70, onTap: onPasteButtonTap, text: "Paste")
          ],
        )
      ],
    ),
  );
}

Widget audioPost() {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 380,
            height: 211,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: bordar,
                )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(soundWave),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 25,
                          width: 62,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                              child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          )),
                        ),
                      ),
                      InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          )),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 25,
                          width: 62,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Center(
                              child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 34,
                      width: 33,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Or',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: bordar),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textField(
                width: 290,
                hight: 48,
                lebelText: 'Paste Verse or Select Verse',
                textfieldBg: TabBG),
            const SizedBox(
              width: 10,
            ),
            button(Height: 45, Width: 70, onTap: () {}, text: "Paste")
          ],
        )
      ],
    ),
  );
}

Widget postPhoto_1({imagepick}) {
  return Padding(
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
                                  image: imagepick.imagePath, fit: BoxFit.fill),
                              color: ContainerBG,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                        width: 280,
                        height: 46,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Photo1202460',
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
              color: TabBG, borderRadius: BorderRadius.circular(19)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
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
                  child:
                      InkWell(onTap: () {}, child: Image.asset(Downarrow_ic)),
                ),
                textfieldBg: TabBG),
          ],
        )
      ],
    ),
  );
}

Widget profileAvatar() {
  return Stack(
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: bordar, borderRadius: BorderRadius.circular(30)),
      ),
      Positioned(
        bottom: 2,
        right: 0,
        child: Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(30)),
        ),
      )
    ],
  );
}

Widget button_(
    {onTap,
    Color? backGroundColor,
    Color? bordarColor,
    double? height,
    double? width,
    String? text,
    Color? textColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 34,
      width: width ?? 78,
      decoration: BoxDecoration(
          color: backGroundColor ?? Colors.transparent,
          border: Border.all(color: bordarColor ?? primary),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
          child: Text(
        text ?? 'Follow',
        style: TextStyle(
            fontSize: 12,
            fontFamily: poppins_semibold,
            color: textColor ?? primary),
      )),
    ),
  );
}

Widget Comments(
    {String user = "",
    String? content,
    String? like,
    String? reply,
    String? share}) {
  final userr = user;
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    profileAvatar(),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userr,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: poppins_semibold,
                              color: Colors.black),
                        ),
                        Text(
                          '03 Sept. At 04:21',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: poppins_regular,
                              color: primaryTxt),
                        ),
                      ],
                    ),
                  ],
                ),
                button_(onTap: () {})
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              content!,
              style: TextStyle(
                  fontFamily: poppins_regular, color: primaryTxt, fontSize: 12),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Image.asset(
                          Share_ic_1,
                        )),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      like!,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: poppins_regular,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        InkWell(onTap: () {}, child: Image.asset(Heart_ic)),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          '36',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: poppins_regular,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Row(
                      children: [
                        InkWell(onTap: () {}, child: Image.asset(Commen_ic_1)),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          '36',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: poppins_regular,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Divider(
        color: bordar,
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget Comments_1() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    profileAvatar(),
                    const SizedBox(
                      width: 12,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Anne Southern',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: poppins_semibold,
                              color: Colors.black),
                        ),
                        Text(
                          '03 Sept. At 04:21',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: poppins_regular,
                              color: primaryTxt),
                        ),
                      ],
                    ),
                  ],
                ),
                button_(onTap: () {})
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
              style: TextStyle(
                  fontFamily: poppins_regular, color: primaryTxt, fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Image.asset(
                          Share_ic_1,
                        )),
                    const SizedBox(
                      width: 7,
                    ),
                    const Text(
                      '36',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: poppins_regular,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        InkWell(onTap: () {}, child: Image.asset(Heart_ic)),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          '36',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: poppins_regular,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Row(
                      children: [
                        InkWell(onTap: () {}, child: Image.asset(Commen_ic_1)),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          '36',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: poppins_regular,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Divider(
        color: bordar,
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget listTielButton({onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: bordar)),
      child: const Center(
          child: Icon(
        Icons.navigate_next_rounded,
        color: primaryTxt,
      )),
    ),
  );
}

class statistic extends StatelessWidget {
  final Color? backGround;
  final String? followers;
  final String? POST;
  final String? following;
  const statistic(
      {super.key,
      required this.backGround,
      this.followers,
      this.POST,
      this.following});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 126,
      color: backGround,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90,
              height: 82,
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Container(
                height: 77.44,
                width: 85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      followers!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: poppins_semibold,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      'Followers',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: poppins_regular,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Container(
              width: 90,
              height: 82,
              decoration: BoxDecoration(
                  color: TabBG, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Container(
                height: 77.44,
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      POST!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: poppins_semibold,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      'Post',
                      style: TextStyle(
                        color: primaryTxt,
                        fontFamily: poppins_regular,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Container(
              width: 90,
              height: 82,
              decoration: BoxDecoration(
                  color: TabBG, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Container(
                height: 77.44,
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      following!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: poppins_semibold,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      'Following',
                      style: TextStyle(
                        color: primaryTxt,
                        fontFamily: poppins_regular,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

Widget menuItem({
  String? title,
  String? subtitle,
  count,
}) {
  return Column(
    children: [
      SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                        fontFamily: poppins_semibold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                        fontFamily: poppins_regular,
                        fontSize: 12,
                        color: primaryTxt),
                  ),
                ],
              ),
              Row(
                children: [
                  if (count > 0)
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          color: primary_1,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                        count!.toString(),
                        style: const TextStyle(
                            color: primary,
                            fontFamily: poppins_regular,
                            fontSize: 12),
                      )),
                    ),
                  const SizedBox(
                    width: 20,
                  ),
                  listTielButton(onTap: () async {
                    if (title == "Messages") {
                      var inboxscr = InboxScreen();
                      await inboxscr.GetUsers();
                      Get.to(() => inboxscr);
                    }
                    if (title == 'Forums') {
                      await Get.to(() => const ForumsScreen());
                    }
                  })
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}

Widget menuButton(
    {VoidCallback? onTap, String? text, Color? txtColor, Color? bordarColor}) {
  return SizedBox(
    height: 58,
    width: 370,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: bordarColor ?? bordar))),
      onPressed: onTap,
      child: Text(
        text!,
        style: TextStyle(
            fontSize: 14, color: txtColor, fontFamily: poppins_semibold),
      ),
    ),
  );
}

Widget profileButton({onTap, String? text, ic}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Image.asset(ic),
        const SizedBox(
          width: 5,
        ),
        Text(
          text!,
          style: const TextStyle(
              color: primary,
              fontSize: 10,
              decoration: TextDecoration.underline,
              decorationColor: primary),
        )
      ],
    ),
  );
}

Widget profileMassageButton() {
  return InkWell(
    onTap: () async {
      Get.to(() => InboxScreen());
    },
    child: Container(
      width: 90,
      height: 28.55,
      decoration: BoxDecoration(
          border: Border.all(color: primary),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(30)),
          ),
          const SizedBox(
            width: 4,
          ),
          Image.asset(Commen_ic_1),
          const SizedBox(
            width: 4,
          ),
          const Text(
            'Message',
            style: TextStyle(
                fontSize: 10, fontFamily: poppins_regular, color: primary),
          )
        ],
      ),
    ),
  );
}

class profilePosts extends StatelessWidget {
  final String username;
  final String caption;
  String? content;
  final String like;
  final String share;
  final String time;
  final List<Comment> comments;
  final Post post;

  profilePosts(
      {super.key,
      required this.post,
      required this.username,
      required this.caption,
      required this.like,
      required this.comments,
      required this.share,
      required this.time,
      this.content});

  @override
  Widget build(BuildContext context) {
    String comment = comments.length.toString();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      profileAvatar(),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                                fontSize: 15,
                                fontFamily: poppins_semibold,
                                color: Colors.black),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: poppins_regular,
                                color: primaryTxt),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                caption,
                style: const TextStyle(
                    fontFamily: poppins_regular,
                    color: primaryTxt,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: ContainerBG,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(content ??
                    "https://i.pinimg.com/736x/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.jpg"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset(
                            Share_ic_1,
                          )),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        share,
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: poppins_regular,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.to(() => CommentScreen(
                                      post: post,
                                    ));
                              },
                              child: Image.asset(Heart_ic)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            like,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: poppins_regular,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {}, child: Image.asset(Commen_ic_1)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            comment,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: poppins_regular,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: bordar,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

Widget profileAvatar_1({double? height, double? width}) {
  return Stack(
    children: [
      Container(
        height: height ?? 48,
        width: width ?? 48,
        decoration: BoxDecoration(
            color: bordar, borderRadius: BorderRadius.circular(30)),
      ),
      Positioned(
        bottom: 2,
        right: 0,
        child: Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30)))),
        ),
      )
    ],
  );
}

Widget chatItem({String? title, String? subTitle, msgCount, onTap}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          width: 375,
          height: 88,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 0)),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profileAvatar_1(),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: poppins_semibold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      subTitle!,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: poppins_regular,
                          fontSize: 12,
                          color: primaryTxt),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '10.00 AM',
                      style: TextStyle(
                          fontFamily: poppins_regular,
                          fontSize: 12,
                          color: primaryTxt),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    msgCount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                msgCount.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: poppins_regular,
                                    fontSize: 12),
                              )),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(child: Image.asset(read)),
                            ),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}

Widget inboxTopItem() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 245,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 16)),
            ]),
        child: TextField(
          style: const TextStyle(
              fontSize: 12, fontFamily: poppins_regular, color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Image.asset(search_ic),
              border: InputBorder.none,
              hintText: 'Search massage',
              hintStyle: const TextStyle(
                  color: primaryTxt,
                  fontSize: 12,
                  fontFamily: poppins_regular)),
        ),
      ),
      Container(
        width: 70,
        height: 46,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 16)),
            ]),
        child: Image.asset(addFriend_ic),
      ),
    ],
  );
}

Widget chatScreenTextField(
    {VoidCallback? micOnTap, VoidCallback? sentOnTap, controller}) {
  return Container(
    height: 116,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 120,
              offset: const Offset(0, 4)),
        ]),
    child: Center(
      child: Container(
        height: 52,
        width: 375,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: TabBG),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 14, fontFamily: poppins_regular),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Type message here...',
              hintStyle: const TextStyle(
                  color: primaryTxt, fontSize: 14, fontFamily: poppins_regular),
              prefixIcon: InkWell(
                  onTap: micOnTap,
                  child: const Icon(
                    CupertinoIcons.mic_fill,
                    color: primaryTxt,
                  )),
              suffixIcon: InkWell(
                  onTap: sentOnTap,
                  child: const Icon(
                    Icons.send_rounded,
                    color: primary,
                  )),
            ),
          ),
        ),
      ),
    ),
  );
}

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}

Widget chatBottomSheet({context}) {
  return Stack(
    children: [
      // Blurred background with centered text
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: const Column(
            children: [
              Icon(
                CupertinoIcons.mic_fill,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Recording Voice Note',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: poppins_regular),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        left: 10,
        right: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                height: 6,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.height * 80,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Image.asset(redDot),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '10:30',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: poppins_regular),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Image.asset(
                    soundWave_1,
                    height: 100,
                    width: 300,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), color: TabBG),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 5, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.mic_fill,
                              color: primary,
                            ),
                          ),
                          const Text(
                            'Release to send',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: poppins_regular,
                                color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.send,
                              color: primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget AddgroupList({String? text, VoidCallback? onTab}) {
  return InkWell(
    onTap: onTab,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          profileAvatar_1(height: 56, width: 56),
          const SizedBox(
            height: 5,
          ),
          Text(
            text!,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontFamily: poppins_regular),
          )
        ],
      ),
    ),
  );
}

Widget createGroupList(
    {String? title,
    String? subTitle,
    String? alphabet,
    icIndex,
    VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                alphabet!,
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: poppins_regular,
                    color: primaryTxt),
              ),
              if (icIndex == 0)
                InkWell(onTap: () {}, child: Image.asset(createGroup_ic))
            ],
          ),
          const Divider(
            color: bordar,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    profileAvatar_1(height: 56, width: 56),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: poppins_semibold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          subTitle!,
                          style: const TextStyle(
                              fontSize: 14,
                              color: primaryTxt,
                              fontFamily: poppins_regular),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: chatContent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Image.asset(vector),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: bordar,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}

Widget AddUserButton({onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Center(child: Image.asset(addUser)),
    ),
  );
}

Widget muteButton({onTap, Color? color, Color? icColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Image.asset(
          mute,
          color: icColor,
        ),
      ),
    ),
  );
}

Widget endCall({onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          color: lightRed, borderRadius: BorderRadius.circular(45)),
      child: Center(
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: red, borderRadius: BorderRadius.circular(45)),
          child: const Icon(
            Icons.call_end_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    ),
  );
}

Widget muteIC() {
  return Container(
    height: 32,
    width: 32,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: Center(
      child: Image.asset(
        mute,
        height: 18,
        width: 18,
      ),
    ),
  );
}

Widget callContainer() {
  return Container(
    height: 273,
    width: 170,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Center(
      child: Stack(
        children: [
          Positioned(top: 10, left: 10, child: muteIC()),
          Container(
            height: 267,
            width: 165,
            decoration: BoxDecoration(
                color: callBg, borderRadius: BorderRadius.circular(16)),
          ),
        ],
      ),
    ),
  );
}

Widget CallScreenBottomSheet({context}) {
  return Stack(
    children: [
      Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Image.asset(close),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.asset(CallBottomSheet_img),
              ),
              const Text(
                'Are You Sure?',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35, right: 35, top: 15),
                child: Text(
                  'Hang up on group video call? please make sure ',
                  style: TextStyle(
                      fontSize: 14,
                      color: primaryTxt,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Text(
                'all goods before hanging up on video call.',
                style: TextStyle(
                    fontSize: 14,
                    color: primaryTxt,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    color: red, borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    'Leave Group Video Call',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

Widget forumScreen_searchBar() {
  return Container(
    height: 43,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: TextField(
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search question",
          hintStyle: const TextStyle(
              fontSize: 14, color: fontColor_2, fontWeight: FontWeight.w400),
          prefixIcon: Image.asset(search)),
    ),
  );
}

Widget categories({onTap, String? text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 71,
        width: 71,
        decoration: BoxDecoration(
            color: categoriesColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          text!,
          style: const TextStyle(
              fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    ),
  );
}

Widget seeAllButton({onTap}) {
  return InkWell(
      onTap: onTap,
      child: const Text(
        'See all',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ));
}

class question extends StatelessWidget {
  final String username;
  final String content;
  final String contentType;

  const question(
      {super.key,
      required this.username,
      required this.content,
      required this.contentType});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const QuestionDetailScreen());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(26)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: primaryTxt,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contentType,
                              style: const TextStyle(
                                  fontSize: 8,
                                  color: primary,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              username,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  content,
                  trimLength: 210,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  moreStyle: const TextStyle(
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      fontStyle: FontStyle.italic),
                  lessStyle: const TextStyle(
                      color: bordar,
                      decoration: TextDecoration.underline,
                      decorationColor: bordar),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class answer extends StatelessWidget {
  final String username;
  final String content;
  final String vote;
  const answer(
      {super.key,
      required this.username,
      required this.content,
      required this.vote});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: primaryTxt,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '{$vote} votes',
                        style: const TextStyle(
                            fontSize: 8,
                            color: red,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: const TextStyle(
                fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    like,
                    height: 10,
                  )),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                  onTap: () {},
                  child: const Text(
                    'Reply',
                    style: TextStyle(
                        fontSize: 8, decoration: TextDecoration.underline),
                  ))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: bordar,
          )
        ],
      ),
    );
  }
}

Widget avatar({double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    decoration:
        BoxDecoration(color: bordar, borderRadius: BorderRadius.circular(30)),
  );
}

Widget forumPost() {
  return Container(
    height: 201,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 0)),
    ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              avatar(height: 33, width: 33),
              const SizedBox(
                width: 7,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiana Rosser',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Song Writer ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum commodo nisl ac eros euismod, a lobortis purus egestas. Sed facilisis laoreet tristique. Donec elementum auctor aliquam.',
            style: TextStyle(
                color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  height: 22,
                  decoration: BoxDecoration(
                      color: bordar, borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                        child: Text(
                      'Music',
                      style: TextStyle(fontSize: 8, color: primaryTxt),
                    )),
                  ),
                ),
              ),
              Container(
                height: 22,
                decoration: BoxDecoration(
                    color: bordar, borderRadius: BorderRadius.circular(8)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                      child: Text(
                    'Entertainment',
                    style: TextStyle(fontSize: 8, color: primaryTxt),
                  )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: bordar,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      like,
                      color: Colors.black,
                      height: 10,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '120 Votes',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(
                      comment,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '13 Replies',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget myGroups({context}) {
  return Container(
    height: 158.86,
    width: MediaQuery.of(context).size.width * 0.80,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 0)),
    ], color: Colors.white, borderRadius: BorderRadius.circular(14)),
    child: Column(
      children: [
        Container(
          height: 118,
          decoration: const BoxDecoration(
              color: groupsBG,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14), topLeft: Radius.circular(14))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  avatar(height: 29, width: 29),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tiana Rosser',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Song Writer',
                        style: TextStyle(
                            fontSize: 8.8,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Total Member: 18,929',
                    style: TextStyle(
                        fontSize: 7.44,
                        color: primaryTxt,
                        fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Text(
                        'Explore Now',
                        style: TextStyle(
                            fontSize: 9.44,
                            color: primary,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            decorationColor: primary,
                            decorationThickness: 2),
                      )),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget Suggestions() {
  return Container(
    height: 202,
    width: 145,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 0)),
        ],
        borderRadius: BorderRadius.circular(9)),
    child: Column(
      children: [
        Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 19,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: group),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                      child: Text(
                    'Recommend',
                    style: TextStyle(color: Colors.black, fontSize: 7),
                  )),
                ),
              ),
            ),
            Container(
              height: 108,
              decoration: const BoxDecoration(
                  color: groupsBG,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9))),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Self & Others',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: poppins_semibold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Suspendisse finibus an turpis aliquam sodale…',
                style: TextStyle(
                    fontSize: 7,
                    fontFamily: poppins_semibold,
                    color: primaryTxt),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {},
                  child: const Text(
                    'Join Now',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: poppins_regular,
                        color: primary,
                        decoration: TextDecoration.underline,
                        decorationColor: primary,
                        decorationThickness: 2),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget GroupsIManage({context}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.90,
    height: 93,
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 0)),
        ],
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Container(
          height: 93,
          width: 93,
          decoration: const BoxDecoration(
              color: groupsBG,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Groups Categories',
                  style: TextStyle(
                      fontSize: 9.82,
                      fontFamily: poppins_regular,
                      color: primaryTxt),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Group Name Goes Here',
                  style: TextStyle(
                      fontSize: 11.46,
                      fontFamily: poppins_semibold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Nunc ornare magna nunc, design to eleifend urna ultrices a.',
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: poppins_semibold,
                    color: primaryTxt,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget donateContent(
    {String? title,
    String? sudTitle,
    ic,
    Color? BGcolor,
    Color? textColor,
    Color? sudTitleColor}) {
  return InkWell(
    onTap: () {},
    child: Container(
      height: 106,
      width: 151,
      decoration: BoxDecoration(
          color: BGcolor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 0)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ic),
          const SizedBox(
            height: 15,
          ),
          Text(
            title!,
            style: TextStyle(
                fontSize: 11,
                color: textColor,
                fontFamily: poppins_regular,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            sudTitle!,
            style: TextStyle(
                fontSize: 11,
                color: sudTitleColor,
                fontFamily: poppins_regular,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

Widget primaryButton_1({onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 39,
      width: double.maxFinite,
      decoration:
          BoxDecoration(color: primary, borderRadius: BorderRadius.circular(5)),
      child: const Center(
          child: Text(
        'Next',
        style: TextStyle(
            fontSize: 11, color: Colors.white, fontFamily: poppins_semibold),
      )),
    ),
  );
}

Widget pageButton(
    {icon,
    Color? bordar,
    String? text,
    Color? textColor,
    Color? BGColor,
    Color? iconColor,
    onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 26,
      width: 83,
      decoration: BoxDecoration(
          color: BGColor,
          border: Border.all(color: bordar ?? primaryTxt),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 12.65,
            color: iconColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text!,
            style: TextStyle(fontSize: 9.49, color: textColor),
          )
        ],
      ),
    ),
  );
}

Widget books() {
  return Column(
    children: [
      Container(
        height: 85,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                lightPrimary_2,
                readBookColorGradient,
              ],
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Genesis',
                    style: TextStyle(
                        fontFamily: poppins_regular,
                        fontSize: 17.73,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '50 Chapters',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: poppins_regular,
                        color: primaryTxt),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 34.09,
                  width: 104.84,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text(
                    'Explore',
                    style: TextStyle(
                        fontSize: 11.93,
                        color: TxtColor,
                        fontFamily: poppins_bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}

Widget donateOptions() {
  return Container(
    height: 170,
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 0)),
      ],
    ),
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Put a Candle',
          style: TextStyle(
              fontSize: 11.5, color: Colors.black, fontFamily: poppins_regular),
        ),
        const SizedBox(
          height: 5,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.money_dollar,
              color: primaryTxt,
              size: 17,
            ),
            Text(
              '2',
              style: TextStyle(
                  fontSize: 11.5,
                  color: primaryTxt,
                  fontFamily: poppins_regular),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Image.asset(
          donation,
          color: primaryTxt,
        ),
        const SizedBox(
          height: 15,
        ),
        Primary_Button(text: 'Choose', Width: 340, onTap: () {})
      ],
    ),
  );
}

Widget donateAmount({Color? backgroundColor, Color? textColor, onTab}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 40),
        child: InkWell(
          onTap: onTab,
          child: Container(
            height: 34.6,
            width: 95.68,
            decoration: BoxDecoration(
                color: backgroundColor, borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(
              '\$100',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: poppins_regular,
                  fontSize: 11.35,
                  color: textColor),
            )),
          ),
        ),
      ),
    ],
  );
}

// Success Toast
void SuccessToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: colorGreen,
      textColor: colorWhite,
      fontSize: 16.0);
}

// Error Toast

void ErrorToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: colorRed,
      textColor: colorWhite,
      fontSize: 16.0);
}

Widget user_tile() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Slidable(
        endActionPane: ActionPane(
            extentRatio: 0.30,
            motion: const ScrollMotion(),
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 23, left: 10),
                  child: Container(
                    height: 80,
                    width: 85,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(delete),
                  ),
                ),
              )
            ]),
        child: chatItem(
            title: userFullname,
            subTitle: userFullname,
            msgCount: 0,
            onTap: () {
              Get.to(() => ChatScreen(
                    recevierEmail: userFullname,
                    receVierId: userId,
                  ));
            })),
  );
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: isCurrentUser ? primary : chatContent,
              borderRadius: isCurrentUser
                  ? const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(4))
                  : const BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(4))),
          child: Text(
            message,
            style: TextStyle(
                color: isCurrentUser ? Colors.white : chatTxtColor,
                fontSize: 16),
          )),
    );
  }
}

Widget commentTextFiled({Context, controller, onTap, focusNode}) {
  return Container(
    height: 110,
    decoration: const BoxDecoration(color: Colors.white),
    child: Center(
      child: Container(
        height: 52,
        width: MediaQuery.of(Context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: bordar),
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Write comment...',
                hintStyle: const TextStyle(fontSize: 14, color: bordar),
                suffixIcon: InkWell(onTap: onTap, child: Image.asset(send))),
          ),
        ),
      ),
    ),
  );
}

class dropdownItem extends StatelessWidget {
  final DropdownController controller = Get.put(DropdownController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          child: DropdownButton<String>(
            value: controller.selectedItem.value,
            onChanged: (newValue) {
              controller.setSelectedItem(newValue!);
            },
            items: [
              DropdownMenuItem<String>(
                value: 'Option 1',
                child: Text('Option 1'),
              ),
              DropdownMenuItem<String>(
                value: 'Option 2',
                child: Text('Option 2'),
              ),
              DropdownMenuItem<String>(
                value: 'Option 3',
                child: Text('Option 3'),
              ),
            ],
          ),
        ));
  }
}

class profile_1 extends StatelessWidget {
  final double? outsideBorder;
  final double? insideBorder;
  final double? outsideBorderRedius;
  final double? insideBorderRedius;
  final bordarColor;
  final onPressed;
  final ImageUrl;
  const profile_1(
      {super.key,
      required this.outsideBorder,
      required this.outsideBorderRedius,
      required this.bordarColor,
      required this.insideBorder,
      required this.insideBorderRedius,
      this.onPressed,
      this.ImageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            height: outsideBorder,
            width: outsideBorder,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(outsideBorderRedius ?? 30),
                border: Border.all(
                    color: bordarColor ?? profileBorder, width: 1.8)),
            child: Center(
              child: Container(
                height: insideBorder,
                width: insideBorder,
                decoration: BoxDecoration(
                  color: bordar,
                  borderRadius: BorderRadius.circular(insideBorderRedius ?? 30),
                ),
                child: Image.network(ImageUrl),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.grey,
                size: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
