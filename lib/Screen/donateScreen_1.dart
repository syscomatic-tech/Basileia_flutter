import 'package:basileia/Screen/leadersScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/controller.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/fonts.dart';
import '../Style/images.dart';

class donateScreen_1 extends StatelessWidget {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: (){},child: const Icon(Icons.arrow_back_rounded,color: Colors.black,)),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('Donate Detail',style: TextStyle(fontSize: 14.49,fontFamily: poppins_semibold,color: Colors.black),),
                    ),
                    InkWell(onTap: (){},child: Image.asset(three_dot,color: Colors.black,))
                  ],
                ),
              ),
              Container(
                height: 119,
                width: double.maxFinite,
                decoration: BoxDecoration(
                   color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Padding(
                  padding:  EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Class Aptent Church',style: TextStyle(fontFamily: poppins_semibold,fontSize: 11.35,color: Colors.black),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(right: 70),
                        child: Text('Nullam non arcu et fermentuma port church  lacinia non elit. Pellentesque habitant morbi',style: TextStyle(fontFamily: poppins_regular,fontSize: 11.35,color: primaryTxt),),
                      ),
                      SizedBox(height: 10,),
                      Text('\$2500',style: TextStyle(fontSize: 12,color: primary,fontFamily: poppins_regular),)
                  ],),
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  InkWell(onTap: (){},child: const Text('edit',style: TextStyle(color: primary,fontFamily: poppins_regular,fontSize: 11.35),))
                ],
              ),
              const SizedBox(height: 20,),
              Container(
                height: 61,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Caspian Bellevedere',style: TextStyle(fontFamily: poppins_regular,fontSize: 11.35,color: Colors.black,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Text('**** **** **** 1234',style: TextStyle(fontFamily: poppins_regular,fontSize: 11.35,color: primaryTxt,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      Container(height: 23.52,
                      width: 37.3,
                      decoration: BoxDecoration(
                        color: donateColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Align(alignment: Alignment.topLeft,child: Text('Donation Amount',style: TextStyle(fontSize: 12.97,fontFamily: poppins_semibold,fontWeight: FontWeight.w500),)),
              const SizedBox(height: 20,),
              SizedBox(
                height: 57,
                width: double.maxFinite,
                child: ListView.builder(
                  physics: const  NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                  return donateAmount(backgroundColor: selected==index?primary:Colors.white,textColor: selected==index?Colors.white:primaryTxt,onTab: (){});
                },),
              ),
              Container(
                height: 39,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: bordar)
                ),
                child: const TextField(
                  style: TextStyle(fontSize: 11.35,fontFamily: poppins_regular),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:'Write the amount…',
                    hintStyle: TextStyle(fontSize: 11.35,fontFamily: poppins_regular,color: primaryTxt),
                    prefixIcon: Icon(CupertinoIcons.money_dollar,color: primary,)
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Align(alignment: Alignment.topLeft,child: Text('Add Note',style: TextStyle(fontFamily: poppins_semibold,fontSize: 12.97,fontWeight: FontWeight.w500),)),
              const SizedBox(height: 20,),
              Container(
                height: 97,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: bordar)
                ),
                child: const Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10,),
                  child: TextField(
                    maxLines: null,
                    style: TextStyle(fontSize: 11.35,fontFamily: poppins_regular),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:'Write your note…',
                        hintStyle: TextStyle(fontSize: 11.35,fontFamily: poppins_regular,color: primaryTxt),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Primary_Button(text: 'Donate',onTap: (){Get.to(()=>LeadersScreen());},Width: 413)
            ],
          ),
        ),
      ),
    );
  }
}
