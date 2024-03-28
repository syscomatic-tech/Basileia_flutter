import 'package:basileia/Screen/addUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/colors.dart';
import '../Style/fonts.dart';
import '../Style/images.dart';
import '../Style/style.dart';

class CreateGroupScreen extends StatelessWidget {
  CreateGroupScreen({super.key});

  final name = [
    'Alexander',
    'Abraham',
    'Adi',
  ];
  final List<String> items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Quince',
    'Raspberry',
    'Strawberry',
  ];
  @override
  Widget build(BuildContext context) {
    items.sort();
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
                        padding: const EdgeInsets.only(top: 45, left: 15),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(arrowLeft)),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Add New Group',
                              style: TextStyle(
                                  fontFamily: poppins_regular,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: name.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AddgroupList(text: name[index],onTab: (){Get.to(()=>AddUserScreen());});
                          },
                        ),
                      )
                    ],
                  )),
            ],
          ),
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  if (index == 0 || items[index][0] != items[index - 1][0]) {
                    return createGroupList(onTap: (){},
                        alphabet: items[index][0],
                        title: items[index],
                        subTitle: items[index],
                    icIndex: index);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
