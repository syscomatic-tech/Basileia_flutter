import 'package:basileia/Screen/questionDetailsScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumsScreen extends StatelessWidget {
  const ForumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool showFAB = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFAB,
        child: FloatingActionButton(onPressed: (){Get.to(()=>const QuestionDetailScreen());},shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),backgroundColor: primary,child: const Icon(Icons.add,color: Colors.white,),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gradient_1, gradient],
            stops: [0.0, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Forums',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ask Question',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(onTap: () {}, child: Image.asset(notification))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                forumScreen_searchBar(),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    seeAllButton(onTap: () {})
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    categories(onTap: () {}, text: 'General'),
                    categories(onTap: () {}, text: 'Bible'),
                    categories(onTap: () {}, text: 'Question'),
                    categories(onTap: () {}, text: 'Motivation'),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Question',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    seeAllButton(onTap: () {})
                  ],
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return question();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
