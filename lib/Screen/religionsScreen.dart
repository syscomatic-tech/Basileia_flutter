import 'package:basileia/Screen/readHolyBookScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/controller.dart';
import '../Style/fonts.dart';

class ReligionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool showFAB = MediaQuery.of(context).viewInsets.bottom != 0;
    final  religionsPageController controller = Get.put(religionsPageController());
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFAB,
        child: FloatingActionButton(onPressed: (){Get.to(()=>ReadHolyBookScreen());},shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),backgroundColor: primary,child: const Icon(Icons.add,color: Colors.white,),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Church Page',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: poppins_semibold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: lightPrimary
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        height: 30,
                        width: 79,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Center(child: Text('View As Church',style: TextStyle(fontSize: 7.26,fontFamily: poppins_regular,color: primary),),),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120,left: 135,right: 135),
                  child: Profile(
                      OutSidehight: 142,
                      OutSidewidth: 142,
                      InSideHight: 130,
                      InsideWidth: 130,
                      InSideRadius: 70,
                      OutSideRadius: 70),
                ),
              ],
            ),
            const SizedBox(height: 13,),
            const Text('Church Name',style: TextStyle(fontSize: 16,fontFamily: poppins_semibold,color: Colors.black),),
            const Padding(
              padding:  EdgeInsets.only(left: 90,right: 90),
              child:  Text('Lorem ipsum dolor sit amet, consec adipiscing elit, sed do eiusmod',style: TextStyle(fontSize: 12,fontFamily: poppins_regular,color: primaryTxt),),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text('Church Leader : ',style: TextStyle(fontSize: 12,color: primary,fontFamily: poppins_semibold),),
               InkWell(onTap: (){},child: const Text('Alexnder Graham',style: TextStyle(fontSize: 8.5,color: Colors.black,fontFamily: poppins_regular,decoration: TextDecoration.underline,decorationThickness: 2),)),
            ],),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pageButton(icon: Commen_ic_1,text: 'Message',onTap: (){}),
                const SizedBox(width: 10,),
                pageButton(icon: donate,text: 'Donate',onTap: (){}),
            ],),
            const SizedBox(height: 15,),
            statistic(backGround: lightPrimary),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
              child: Column(
                children: [
                  const Align(alignment: Alignment.topLeft,
                   child: Text('Priest',style: TextStyle(fontFamily: poppins_regular,fontSize: 20,fontWeight: FontWeight.w500),)),
              const SizedBox(height: 10,),
              Container(height: 68.4,
                decoration:  BoxDecoration(
                    color: lightPrimary,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13,right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: lightPrimary_1,
                              borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 12,left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text('Theodore Handle',style: TextStyle(color: Colors.black,fontFamily: poppins_semibold),),
                                Text('Pastor',style: TextStyle(color: primaryTxt,fontFamily: poppins_regular),),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Text('View Profile',style: TextStyle(decoration: TextDecoration.underline,decorationColor: primary,color: primary,fontFamily: poppins_regular,fontSize: 7.67),),
                      ),

                    ],
                  ),
                ),
              )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25,left: 15,right: 15),
              child: Column(
                children: [
                  const Align(alignment: Alignment.topLeft,
                      child: Text('Church Communication',style: TextStyle(fontFamily: poppins_regular,fontSize: 13.26,fontWeight: FontWeight.w500),)),
                  const SizedBox(height: 15,),
                  Container(height: 99,
                    width: double.maxFinite,
                    decoration:  BoxDecoration(
                        color: lightPrimary,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13,right: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 31,
                                width: 31,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: const Center(child: Icon(Icons.location_on_outlined,color: primary,),),
                              ),
                              const SizedBox(width: 10,),
                              const Text('Donec Street, Ullamcorper Elit 12/7',style: TextStyle(decoration: TextDecoration.underline,color: primaryTxt,decorationColor: primaryTxt),)
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              Container(
                                height: 31,
                                width: 31,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Center(child: Image.asset(call_icon)),
                              ),
                              const SizedBox(width: 10,),
                              const Text('123 673 2198',style: TextStyle(color: primaryTxt),)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 35,),
            TabBar(
              indicatorColor: primary,
              labelColor: primary,
              unselectedLabelColor: primaryTxt,
              indicatorWeight: 2,
              dividerColor: bordar,
              dividerHeight: 1,
              controller: controller.tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              tabs: [
                const Tab(
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Tab(
                  child: Text(
                    'News',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Tab(
                  child: Text(
                    'Sunday services',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Tab(
                  child: Image.asset(vector_5),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.90, // Adjust the height as needed
              width: double.maxFinite,
              child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    ListView.builder(itemCount: 10, shrinkWrap: true,primary:false,itemBuilder: (BuildContext context, int index) {return Comments();},),
                    ListView.builder(itemCount: 2, shrinkWrap: true,primary: false,itemBuilder: (BuildContext context, int index) {return Comments();},),
                    ListView.builder(itemCount: 2, shrinkWrap: true,primary: false,itemBuilder: (BuildContext context, int index) {return Comments();},),
                    ListView.builder(itemCount: 2, shrinkWrap: true,primary: false,itemBuilder: (BuildContext context, int index) {return Comments();},),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
