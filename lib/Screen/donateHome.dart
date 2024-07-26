import 'package:basileia/Screen/religionsScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateHome extends StatelessWidget {
  final title = [
    'Search Church',
    'Scripture',
    'News',
    'Donation',
    'Churches',
    'Priests',
    '360°',
    'More',
  ];
  final sudtitle = [
    'Nearest churches',
    'Praesent nulla met',
    'Churches news',
    'Porttitor nec ante',
    'Porttitor nec ante',
    'Nullam hendrerit',
    'Class aptent',
    'Class aptent',
  ];
  final image = [
    location_1,
    location_1,
    news,
    donation,
    donation,
    donation,
    classAptent,
    more
  ];
  final textColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.white,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];
  final sudtitleColor = [
    primaryTxt,
    primaryTxt,
    primaryTxt,
    Colors.white,
    primaryTxt,
    primaryTxt,
    primaryTxt,
    primaryTxt,
  ];
  final bgColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    primary,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Donate',
                      style: TextStyle(
                          fontSize: 14.49,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
              ),
              GridView.builder(
                itemCount: title.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return donateContent(
                      title: title[index],
                      sudTitle: sudtitle[index],
                      ic: image[index],
                      BGcolor: bgColor[index],
                      textColor: textColor[index],
                      sudTitleColor: sudtitleColor[index]);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.4),
              ),
              const SizedBox(
                height: 20,
              ),
              primaryButton_1(onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
