import 'package:basileia/Screen/SignInScreen.dart';
import 'package:basileia/Screen/homeFeedScreen.dart';
import 'package:basileia/Style/colors.dart';
import 'package:basileia/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../RestAPI/RestClient.dart';
import '../Style/images.dart';

class SignUpOtpScreen extends StatelessWidget {
  String email = "";
  AuthClient cln = AuthClient();
  TextEditingController contr = TextEditingController();

  SignUpOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'We send a code in your mail.',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const Text(
              'Please check mail.',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            OtpField(controller: contr),
            const SizedBox(
              height: 50,
            ),
            Primary_Button(
                onTap: () async {
                  final req_outp = await cln.VerifyOTPRequest(
                      this.email, contr.text.toString());
                  print(req_outp);
                  if (req_outp == true) {
                    SuccessToast("Sucsexfully logged in");
                    Get.to(() => HomeFeedScreen());
                  } else {
                    ErrorToast("Error occured please check logs");
                  }
                },
                text: 'Jump To Home',
                Width: 272),
            const Padding(
              padding: EdgeInsets.only(left: 45, right: 45, top: 20),
              child: Divider(
                color: bordar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70, right: 70, top: 15),
              child: RichText(
                  text: const TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Protected by reCAPTCHA and subject to the Rhombus ',
                    style: TextStyle(fontSize: 12, color: textFi)),
                TextSpan(
                    text: 'Privacy Policy ',
                    style: TextStyle(fontSize: 12, color: primary)),
                TextSpan(
                    text: 'and', style: TextStyle(fontSize: 12, color: textFi)),
                TextSpan(
                    text: ' Terms of Service.',
                    style: TextStyle(fontSize: 12, color: primary)),
              ])),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(alignment: Alignment.bottomLeft, child: Image.asset(union))
          ],
        ),
      ),
    );
  }
}
