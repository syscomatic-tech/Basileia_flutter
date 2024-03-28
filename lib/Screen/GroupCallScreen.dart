import 'package:basileia/Screen/forumsScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/controller.dart';

class GroupCallScreen extends StatelessWidget {
  final ColorController colorController = Get.put(ColorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(alignment: Alignment.topRight, child: Image.asset(union_1)),
          Align(alignment: Alignment.bottomLeft, child: Image.asset(union)),
          Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 145),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 32,
                          width: 72,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: primary)),
                          child: const Center(
                              child: Text(
                            '10:03:42',
                            style: TextStyle(color: primary, fontSize: 12),
                          )),
                        ),
                        const SizedBox(
                          width: 90,
                        ),
                        InkWell(onTap: () {}, child: Image.asset(routeCamera)),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(onTap: () {}, child: Image.asset(cameraOff)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            callContainer(),
                            const SizedBox(
                              width: 10,
                            ),
                            callContainer()
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            callContainer(),
                            const SizedBox(
                              width: 10,
                            ),
                            callContainer()
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 65, right: 65, bottom: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddUserButton(onTap: () {Get.to(()=>ForumsScreen());}),
                        endCall(onTap: () {
                          Get.bottomSheet(
                              CallScreenBottomSheet(context: context));
                        }),
                        Obx(() => muteButton(
                            onTap: () {
                              colorController.toggleColor();
                            },
                            color: colorController.isMute.value
                                ? chatTxtColor
                                : Colors.white,
                            icColor: colorController.isMute.value
                                ? Colors.white
                                : chatTxtColor))
                      ],
                    ),
                  )
                ],
              ),
          )
        ],
      ),
    );
  }
}
