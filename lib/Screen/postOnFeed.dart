import 'package:basileia/Screen/postOnFeed_1.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/controller.dart';

class PostOnFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyTabsController controller = Get.put(MyTabsController());
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
                  button(Width:72, Height:45, onTap:() {Get.to(()=>PostOnFeed_1());}, text:'Next')
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
            Container(
              child: SizedBox(
                width: double.maxFinite,
                height: 500,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    PostPhoto(),
                    PostPhoto(),
                    audioPost()
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
