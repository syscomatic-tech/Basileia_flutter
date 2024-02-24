import 'package:basileia/Screen/HolyBookScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/controller.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LeadersController leadersController = Get.put(LeadersController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Church Leader',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: poppins_semibold),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: bordar,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50,
                top: 10,
              ),
              child: Row(
                children: [
                  Profile(
                      OutSidehight: 120,
                      OutSidewidth: 120,
                      InSideHight: 110,
                      InsideWidth: 110,
                      bordarColor: primary,
                      OutSideRadius: 60,
                      InSideRadius: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alexnder Graham',
                          style: TextStyle(
                              fontSize: 14.37,
                              fontFamily: poppins_semibold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                            width: 177,
                            child: Text(
                              'Lorem ipsum dolor sit amet, consec adipiscing elit, sed do eiusmod',
                              style: TextStyle(
                                  fontSize: 9.07,
                                  fontFamily: poppins_regular,
                                  color: primaryTxt),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text(
                              '6.3k',
                              style: TextStyle(fontFamily: poppins_semibold),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '572',
                              style: TextStyle(fontFamily: poppins_semibold),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              '2.5K',
                              style: TextStyle(fontFamily: poppins_semibold),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Text(
                              'Followers',
                              style: TextStyle(
                                  fontSize: 5.87, fontFamily: poppins_regular),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Post',
                              style: TextStyle(
                                  fontSize: 5.87, fontFamily: poppins_regular),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Amin',
                              style: TextStyle(
                                  fontSize: 5.87, fontFamily: poppins_regular),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            pageButton(
                                BGColor: primary,
                                icon: Commen_ic_1,
                                text: 'Follow',
                                textColor: Colors.white,
                                iconColor: Colors.white,
                                bordar: Colors.transparent,
                                onTap: () {
                                  Get.to(() => HolyBookScreen());
                                }),
                            const SizedBox(
                              width: 10,
                            ),
                            pageButton(
                                icon: Commen_ic_1,
                                text: 'Message',
                                textColor: primaryTxt,
                                iconColor: primary,
                                bordar: primary,
                                onTap: () {}),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TabBar(
              indicatorColor: primary,
              labelColor: primary,
              unselectedLabelColor: primaryTxt,
              indicatorWeight: 2,
              dividerColor: bordar,
              controller: leadersController.tabController,
              dividerHeight: 1,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: const [
                Tab(
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sermons',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Audio',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    ' Quotes',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.92,
              child: TabBarView(controller: leadersController.tabController, children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Comments();
                  },
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 141,
                      width: 89,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(viewIcon,),
                              const Text('23.5K',style: TextStyle(color: primaryTxt,fontSize: 4,fontFamily: poppins_regular),)
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(reactIcon),
                              const Text('23.5K',style: TextStyle(color: primaryTxt,fontSize: 4,fontFamily: poppins_regular),)
                            ],
                          ),
                        ],
                      ),
                    );
                  }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 0.70),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return AudioFeeds();
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Comments();
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
