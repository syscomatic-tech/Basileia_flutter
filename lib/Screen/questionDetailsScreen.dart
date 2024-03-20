import 'package:basileia/Screen/forumProfile.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionDetailScreen extends StatelessWidget {
  const QuestionDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 190,
            color: primary,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(backArrow)),
                  const SizedBox(
                    width: 90,
                  ),
                  const Text(
                    'Question Details',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 125, left: 30, right: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                question(username: '',content: '',contentType: '',),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Answer',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    seeAllButton(onTap: () {})
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(26)),
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return answer(username: '',content: '',vote: '',);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Center(
                child: Container(
                  height: 52,
                  width: MediaQuery.of(context).size.width*0.90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: bordar),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write comment...',
                        hintStyle: const TextStyle(fontSize: 14,color: bordar),
                        suffixIcon: InkWell(onTap: (){Get.to(()=>ForumsProfile());},child: Image.asset(send))
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
