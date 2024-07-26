
import 'package:basileia/Screen/donateHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Style/style.dart';

class GroupsScreen extends StatelessWidget {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Align(alignment: Alignment.center,child: Text('Groups',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),)),
          ),

            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Groups',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  seeAllButton(onTap: () {})
                ],
              ),
            ),
           const SizedBox(height: 10,),
           SizedBox(
             height: 200,
             child: ListView.builder(shrinkWrap: true,
               scrollDirection: Axis.horizontal,
               itemCount: 3,
               itemBuilder: (BuildContext context, int index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: myGroups(context: context),
               );
               },),
           ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Suggestions',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  seeAllButton(onTap: () {})
                ],
              ),
            ),
            SizedBox(
              height: 230,
                child:
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Suggestions(),
                    );
                  },)
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Groups I Manage',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  seeAllButton(onTap: () {})
                ],
              ),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){},
                      child: GroupsIManage(context: context)),
                );
              },)
          ],
        ),
      ),
    );
  }
}
