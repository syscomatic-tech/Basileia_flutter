import 'package:basileia/Screen/donateScreen.dart';
import 'package:basileia/Screen/leadersScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/style.dart';

class ReadHolyBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 23, right: 23),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back_rounded),
                    const Text(
                      'Bible',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: poppins_semibold,
                        color: Colors.black,
                      ),
                    ),
                    Image.asset(three_dot)
                  ],
                ),
              ),
              SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Continue Reading',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      seeAllButton(onTap: () {})
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 111,
                        height: 160,
                        decoration: BoxDecoration(
                            color: lightPrimary_2,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bible',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: poppins_regular,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const Text(
                            'Chapter 4 of 8',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: poppins_regular,
                                color: primaryTxt),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Last reading: Genesis chapter 3.',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: poppins_regular,
                                color: primaryTxt),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Primary_Button(
                              onTap: () {Get.to(()=>DonateScreen());}, text: 'Continue', Width: 186),
                        ],
                      )
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return books();
                    },
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
