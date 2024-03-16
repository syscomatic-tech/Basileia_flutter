import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  final menuTitle=[
    'Connections',
    'Messages',
    'Church Page',
    'Forums',
    'Groups',
    'Delate Account',
    'Donation History',
    'Language',
  ];
  final menuSubTitle=[
    'Friendlist totals',
    'Message your friends',
    'Message your friends',
    'See your recent activity',
    'Message your friends',
    'Message your friends',
    'Checkout your previous donation history',
    'Change your language from here',
  ];
  final menuCount=[
    0,0,0,0,0,0,0,0,0,0
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Profile(onPressed:() {}, OutSidehight:55, OutSidewidth:55, InSideHight:45, InsideWidth:45),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prince Armand',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: poppins_semibold,
                                    fontSize: 16),
                              ),
                              Text(
                                '@princearmand100',
                                style: TextStyle(
                                    color: primaryTxt,
                                    fontFamily: poppins_regular,
                                    fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      listTielButton(onTap: (){})
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            statistic(backGround: primary_1),
            ListView.builder(
              itemCount: menuTitle.length,
              itemBuilder: (context, index) {
                return menuItem(title:menuTitle[index], subtitle:menuSubTitle[index], count:menuCount[index]);
              },
              shrinkWrap: true,
              primary: false,
            ),
            const SizedBox(height: 10,),
            const Divider(color: bordar,),
            const SizedBox(height: 18,),
            menuItem(title:'Privacy Policy', subtitle:'Protect your privacy', count:0),
            const SizedBox(height: 10,),
            menuButton(onTap:(){},bordarColor:primary,txtColor: primary,text: 'Switch To Church Profile'),
            const SizedBox(height: 15,),
            menuButton(onTap:(){},bordarColor:menuItem_,txtColor: menuItem_,text: 'Log out'),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
