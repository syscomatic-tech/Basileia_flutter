import 'package:flutter/material.dart';

import '../Style/style.dart';

class createGroupBottomSheet extends StatelessWidget {
  final List<String> userids;
  const createGroupBottomSheet({super.key, required this.userids});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: textField(
                suffixIcon: null,
                lebelText: 'Group name',
                width: MediaQuery.of(context).size.width * 0.70),
          ),
          button(
              onTap: () {},
              text: "Create Group",
              Width: MediaQuery.of(context).size.width * 0.70,
              Height: 50)
        ],
      ),
    );
  }
}
