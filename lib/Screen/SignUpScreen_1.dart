import 'package:basileia/Screen/SignUpOtpScreen.dart';
import 'package:basileia/Style/images.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Style/colors.dart';

class SignUpScreen_1 extends StatelessWidget {
  final PasswordController controller = Get.put(PasswordController());
  @override
  Widget build(BuildContext context) {
    final CheckboxController checkboxController = Get.put(CheckboxController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Align(alignment: Alignment.topCenter, child: Image.asset(appLogo)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sign up',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
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
              height: 20,
            ),
            textField('First name', null),
            const SizedBox(
              height: 20,
            ),
            textField('Last name', null),
            const SizedBox(
              height: 20,
            ),
            textField('Email address', null),
            const SizedBox(
              height: 20,
            ),
            Obx(
              ()=>textField(
                'Password',
                IconButton(onPressed: () { controller.isObscured.value = !controller.isObscured.value;
                }, icon:  Icon(
                  controller.isObscured.value ? Icons.visibility : Icons.visibility_off,color: textFi,
                ),),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Primary_Button(
                onTap: () {
                  Get.to(() => SignUpOtpScreen());
                },
                text: 'Sign In',
                Width: 272),
            const Padding(
              padding: EdgeInsets.only(left: 71, right: 71, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Divider(
                    color: bordar,
                    thickness: 1,
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Or',
                    style: TextStyle(color: textFi),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      child: Divider(
                    color: bordar,
                    thickness: 1,
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 71, right: 71),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ic_Button(
                      hight: 48,
                      width: 124,
                      onTap: () {},
                      text: "Google",
                      icon: Image.asset(google)),
                  const SizedBox(
                    width: 20,
                  ),
                  ic_Button(
                      hight: 48,
                      width: 124,
                      onTap: () {},
                      text: "Facebook",
                      icon: Image.asset(facebook))
                ],
              ),
            ),
            Stack(
              children: [
                Align(
                    alignment: Alignment.bottomLeft, child: Image.asset(union)),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 62, right: 62, top: 10),
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              checkColor: Colors.white,
                              activeColor: primary,
                              value: checkboxController.isChecked.value,
                              onChanged: (value) {
                                checkboxController.isChecked.value = value!;
                              },
                            ),
                          ),
                          const Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'By clicking Create account, I agree that I have read and accepted the Terms of Use and Privacy Policy.',
                              style: TextStyle(fontSize: 12, color: textFi),
                            ),
                          ))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 35, right: 35, top: 15),
                      child: Divider(
                        thickness: 1.5,
                        color: bordar,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 70, right: 70, top: 15),
                      child: RichText(
                          text: const TextSpan(children: <TextSpan>[
                        TextSpan(
                            text:
                                'Protected by reCAPTCHA and subject to the Rhombus ',
                            style: TextStyle(fontSize: 12, color: textFi)),
                        TextSpan(
                            text: 'Privacy Policy ',
                            style: TextStyle(fontSize: 12, color: primary)),
                        TextSpan(
                            text: 'and',
                            style: TextStyle(fontSize: 12, color: textFi)),
                        TextSpan(
                            text: ' Terms of Service.',
                            style: TextStyle(fontSize: 12, color: primary)),
                      ])),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CheckboxController extends GetxController {
  var isChecked = true.obs; // 'obs' makes it observable
}
class PasswordController extends GetxController {
  var isObscured = true.obs;
}