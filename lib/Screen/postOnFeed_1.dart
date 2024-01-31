
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/colors.dart';
import '../Style/controller.dart';
import '../Style/fonts.dart';
import '../Style/style.dart';

class PostOnFeed_1 extends StatelessWidget {  @override
  Widget build(BuildContext context) {
  final TabsController controller_1 = Get.put(TabsController());
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
                  button(Width:72, Height:45, onTap:() {Get.to(()=>PostOnFeed_1());}, text:'Post'),
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
              padding: const EdgeInsets.only(right: 200),
              child: Container(
                width: 168,
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
                  controller: controller_1.tabController,
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.maxFinite,
              height: 500,
              child: TabBarView(
                controller: controller_1.tabController,
                children: [
                  postPhoto_1(),
                  PostPhoto(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
