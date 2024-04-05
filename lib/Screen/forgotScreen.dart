import 'package:basileia/Screen/SignInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:basileia/RestAPI/RestClient.dart';
import 'package:get/get.dart';
import '../Style/colors.dart';
import '../Style/controller.dart';
import '../Style/images.dart';
import '../Style/style.dart';

class ForgotPasswordScreen extends StatelessWidget {
  String otp = "";
  final AuthClient auth = AuthClient();
  final TextEditingController password = TextEditingController();
  final PasswordController controller = PasswordController();
  ForgotPasswordScreen({Key? key, required this.otp}) : super(key: key);
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
          'Change password',
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 20,
        ),
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
        const SizedBox(
          height: 30,
        ),
        Primary_Button(
            onTap: () async {
              if (password.text.toString().isNotEmpty) {
                SuccessToast("Processing");
                SuccessToast(
                    await auth.ResetPassword(password.text.toString(), otp));
                Get.to(() => SignInScreen());
              } else {
                ErrorToast("Please enter password");
              }
            },
            text: 'Change password',
            Width: 272),
        const SizedBox(
          height: 20,
        ),
      ]),
    ));
  }
}
