import 'package:basileia/Screen/SignUpScreen_1.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(union_1)),
                  Positioned(top: 59, left: 152, child: Image.asset(appLogo)),
                ],
              ),
              const Text(
                'Sign up',
                style: TextStyle(
                    fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 14,
                            color: primary,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Create an account as',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 70, left: 70, top: 10),
                child: Text(
                  'We are lorem ipsum team dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.67,
                      height: 1.7,
                      color: fonts),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Basic_Button(
                  onTap: () {
                    Get.to(() => SignUpScreen_1());
                  },
                  text: 'Basic User'),
              const SizedBox(
                height: 20,
              ),
              Basic_Button(onTap: () {}, text: 'Celebrities / VIPs'),
              const SizedBox(
                height: 20,
              ),
              Basic_Button(onTap: () {}, text: 'Church Leader'),
              const SizedBox(
                height: 20,
              ),
              Basic_Button(onTap: () {}, text: 'Church Page'),
              const SizedBox(
                height: 20,
              ),
              Primary_Button(onTap: () {},text: 'Jump To Next',Width: 272),
              Align(alignment: Alignment.bottomLeft,child: Image.asset(union)),
            ],
          ),
    ));
  }
}
