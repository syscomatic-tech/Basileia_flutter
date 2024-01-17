import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import 'colors.dart';

Widget Basic_Button({
  onTap,
  String? text,
}) {
  return SizedBox(
    height: 44.13,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: bordar))),
        onPressed: onTap,
        child: Text(
          text!,
          style: const TextStyle(fontSize: 12.75, color: Colors.black),
        )),
  );
}

Widget Primary_Button({onTap, String? text, double? Width}) {
  return SizedBox(
    height: 48,
    width: Width,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onTap,
        child: Text(
          text!,
          style: const TextStyle(fontSize: 12.75, color: Colors.white),
        )),
  );
}

Widget textField(String? lebelText, suffixIcon) {
  return Container(
    width: 272,
    height: 48,
    decoration: BoxDecoration(
        border: Border.all(
          color: bordar,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 10),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          hintText: lebelText,
          hintStyle: const TextStyle(fontSize: 14, color: textFi,fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}

Widget ic_Button(
    {VoidCallback? onTap, String? text, icon, double? hight, double? width}) {
  return SizedBox(
    height: hight,
    width: width,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: bordar))),
      onPressed: onTap,
      label: Text(
        text!,
        style: const TextStyle(fontSize: 12.75, color: Colors.black),
      ),
      icon: icon,
    ),
  );
}
 Widget OtpField (){
  final defaultPinTheme = PinTheme(
    width: 58,
    height: 46,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: bordar),
      borderRadius: BorderRadius.circular(10)
    )
  );
  return Pinput(
    length: 4,
    defaultPinTheme: defaultPinTheme,
    focusedPinTheme: defaultPinTheme,
  );
 }
