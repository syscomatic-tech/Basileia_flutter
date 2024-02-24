
import 'package:basileia/Screen/groupsScreen.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/colors.dart';

class ForumsProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 131,
                  color: primary,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 70, left: 150, right: 150),
                  child: Container(
                    height: 104,
                    width: 104,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Prince Armand Kedje',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'User',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Post',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      seeAllButton(onTap: () {})
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 forumPost(),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Saved Post',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      seeAllButton(onTap: () {Get.to(()=>GroupsScreen());})
                    ],
                  ),
                  const SizedBox(height: 10,),
                  forumPost(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
