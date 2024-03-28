
import 'package:basileia/RestAPI/RestClient.dart';
import 'package:basileia/Screen/SignUpScreen.dart';
import 'package:basileia/Screen/forgotScreen.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Style/colors.dart';
import '../Style/controller.dart';
import '../Style/images.dart';
import '../Style/style.dart';

class SignInScreen extends StatelessWidget {
  final AuthClient auth = AuthClient();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final PasswordController controller = Get.put(PasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 40,
        ),
        Align(alignment: Alignment.topCenter, child: Image.asset(appLogo)),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Sign in',
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
              'Don’t have an account?',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 3,
            ),
            InkWell(
                onTap: () {
                  Get.to(() => SignUpScreen());
                },
                child: const Text(
                  'Sign Up',
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
        textField(
            width: 272,
            hight: 48,
            lebelText: 'Email address',
            controller: email),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => textField(
            obscureText: controller.isObscured.value,
              width: 272,
              hight: 48,
              lebelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  controller.isObscured.value = !controller.isObscured.value;
                },
                icon: Icon(
                  controller.isObscured.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: textFi,
                ),
              ),
              controller: password),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 160),
          child: InkWell(
              onTap: () {Get.to(()=>ForgotPasswordScreen());},
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                    fontSize: 14, color: primary, fontWeight: FontWeight.w400),
              )),
        ),
        const SizedBox(
          height: 30,
        ),
        Primary_Button(
            onTap: () async {
              final req_outp = await auth.LoginRequest(
                  email.text.toString(), password.text.toString());
              try {
                if (!req_outp.contains("Error")) {
                  SuccessToast(req_outp);
                  final hm_screen = HomeFeedScreen();
                  Get.to(() => hm_screen);
                } else {
                  ErrorToast("Please Login with accurate credentials. ");
                }
              } catch (Error) {
                ErrorToast(req_outp);
              }
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
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Image.asset(union),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ic_Button(
                      hight: 48,
                      width: 124,
                      onTap: () {},
                      text: "Google",
                      icon: Image.asset(google),
                    ),
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
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70, top: 15),
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
                ),
              ],
            ),
          ],
        )
      ]),
    ));
  }
}
