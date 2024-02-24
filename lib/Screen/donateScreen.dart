import 'package:basileia/Screen/donateScreen_1.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/fonts.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateScreen extends StatelessWidget {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 187.5,
                  width: double.maxFinite,
                  color: primary,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,bottom: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(onTap: (){},child: const Icon(Icons.arrow_back_rounded,color: Colors.white,)),
                        const Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text('Donate Detail',style: TextStyle(fontSize: 14.49,fontFamily: poppins_semibold,color: Colors.white),),
                        ),
                        InkWell(onTap: (){},child: Image.asset(three_dot,color: Colors.white,))
                      ],
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 114,),
                    child: Container(
                      height: 172,
                      width: 205.31,
                      decoration: BoxDecoration(
                        color: lightPrimary_2,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Padding(
              padding:  const EdgeInsets.only(left: 20,right: 20),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sunny City Church',style: TextStyle(fontSize: 13.14,fontFamily: poppins_bold,color: Colors.black),),
                  const SizedBox(height: 8,),
                  const Text('Nulla pellentesque tellus et lacus tincidunt, a et auctor quam tincidunt. Praesent aliquet church',style: TextStyle(fontSize: 11.5,fontFamily: poppins_regular,color: primaryTxt),),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Primary_Button(onTap: (){Get.to(()=>donateScreen_1());},text: "Follow",Width: 172.75),
                      Primary_Button(onTap: (){},text: "Share",Width: 172.75,backgroundColor: Colors.white,textColor: primary),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const Text('Select a Operation',style: TextStyle(fontFamily: poppins_regular,fontSize: 13.14),),
                  const SizedBox(height: 20,),
                  donateOptions(),
                  const SizedBox(height: 15,),
                  donateOptions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
