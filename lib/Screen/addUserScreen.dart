import 'package:basileia/Screen/GroupCallScreen.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/images.dart';

class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  height: 400,
                  color: primary,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 15),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                    child: Icon(
                                  CupertinoIcons.arrow_left,
                                  color: chatTxtColor,
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Add User to Join Call',
                              style: TextStyle(
                                  fontFamily: poppins_regular,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 58,
                        width: 377,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 14, fontFamily: poppins_regular),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search contact...',
                              hintStyle: const TextStyle(
                                  color: primaryTxt,
                                  fontSize: 14,
                                  fontFamily: poppins_regular),
                              prefixIcon: Image.asset(search_),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Expanded(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          profileAvatar_1(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Michael John',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Image.asset(conform)
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
                                  height: 5,
                                )
                              ],
                            );
                          },
                        ),
                        Positioned(
                          right: 35,
                          left: 35,
                          bottom: 20,
                          child: InkWell(
                            onTap: () {Get.to(()=>GroupCallScreen());},
                            child: Container(
                              height: 50,
                              width: 327,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                  child: Text(
                                'Add to Video Call',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
