import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:flutter/material.dart';

import '../Style/fonts.dart';
import '../Style/style.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  String bio = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Row(
              children: [
                arrowButton(),
                SizedBox(width: MediaQuery.of(context).size.width*0.30,),
                const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: poppins_semibold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: bordar,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        button_(
                            onTap: () {},
                            text: 'Friends',
                            backGroundColor: primary_1,
                            bordarColor: Colors.transparent,
                            height: 40,
                            width: 85),
                        button_(
                            onTap: () {},
                            text: 'My Activity',
                            backGroundColor: Colors.transparent,
                            bordarColor: bordar,
                            height: 40,
                            width: 94,
                            textColor: bordar),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Profile(
                        OutSidehight: 120,
                        OutSidewidth: 120,
                        InSideHight: 110,
                        InsideWidth: 110,
                        InSideRadius: 60,
                        OutSideRadius: 60),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      userFullname,
                      style: const TextStyle(
                          fontSize: 16, fontFamily: poppins_semibold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65, right: 65),
                      child: Text(
                        bio,
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: poppins_regular,
                            color: primaryTxt),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 65, right: 65),
                      child: Text(
                        bio,
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: poppins_regular,
                            color: primaryTxt),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profileButton(
                            onTap: () {}, text: 'Location', ic: location_ic),
                        const SizedBox(
                          width: 15,
                        ),
                        profileMassageButton(),
                        const SizedBox(
                          width: 10,
                        ),
                        profileButton(
                            onTap: () {},
                            text: 'Church I attend',
                            ic: institution_ic),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    statistic(
                      backGround: TabBG,
                      following: '',
                      POST: '',
                      followers: '',
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return profilePosts(
                          like: '',
                          caption: '',
                          content: '',
                          comment: '',
                          share: '',
                          username: '',
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
