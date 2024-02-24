
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';

class HolyBookScreen extends StatelessWidget {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 214,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: bookPageColor,
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text('Hello, Derno👋',style: TextStyle(fontSize: 20,fontFamily: poppins_semibold,color: primary),),
                        Text('what do you want to',style: TextStyle(fontFamily: poppins_regular,fontSize:16,fontWeight: FontWeight.w400,color: chatTxtColor),),
                        Text('read today?',style: TextStyle(fontFamily: poppins_regular,fontSize:16,fontWeight: FontWeight.w400,color: chatTxtColor),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 165,left: 40,right: 40),
                  child: Container(
                    height: 91,
                    width: 327,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('More serious exercise',style: TextStyle(fontSize: 16,fontFamily: poppins_regular,fontWeight: FontWeight.w500,color: Colors.white),),
                        Text('get more features and',style: TextStyle(fontSize: 14,fontFamily: poppins_regular,fontWeight: FontWeight.w400,color: Colors.white),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30,left: 24,right: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Continue Reading',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: poppins_regular),),
                      seeAllButton(onTap: (){})
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 184,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 0)),
                        ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          height: 160,
                          width: 104,
                          decoration: BoxDecoration(
                            color: lightPrimary_2,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Bible',style: TextStyle(fontFamily: poppins_regular,color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 5,),
                              const Text('Chapter 4 of 8',style: TextStyle(fontFamily: poppins_regular,color: primaryTxt,fontSize: 12,fontWeight: FontWeight.w400),),
                              const SizedBox(height: 5,),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: LinearProgressIndicator(
                                      value: 0.5,
                                      backgroundColor: progressBarBGColor,
                                      borderRadius: BorderRadius.circular(5),
                                      valueColor: const AlwaysStoppedAnimation(primary),
                                      minHeight: 4,
                                    ),
                                  ),
                                  const SizedBox(width: 7,),
                                  const Text('50%',style: TextStyle(fontSize: 12,color: primaryTxt,fontFamily: poppins_regular,fontWeight: FontWeight.w400),),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Primary_Button(onTap: (){},text: 'Explore',Width: 186)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text('Read Holy Books',style: TextStyle(fontFamily: poppins_regular,fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                    seeAllButton(onTap: (){})
                  ],),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        height: 114,
                        width: 93,
                        decoration: BoxDecoration(
                          color: lightPrimary_2,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Bible',style: TextStyle(fontFamily: poppins_regular,color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
                          const SizedBox(height: 5,),
                          const Text('English',style: TextStyle(fontFamily: poppins_regular,color: primaryTxt,fontSize: 12,fontWeight: FontWeight.w400),),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Primary_Button(onTap: (){},text:'Read Now',),
                              const SizedBox(width: 10,),
                              Primary_Button(onTap: (){},text:'Read Later',backgroundColor: Colors.white,textColor: TxtColor),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
