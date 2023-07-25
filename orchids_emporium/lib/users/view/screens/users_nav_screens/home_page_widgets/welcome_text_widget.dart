// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/profile_screen_user.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          //top: MediaQuery.of(context).padding.top + 10,
          bottom: 10,
          left: 14,
          right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) {
          //         return UserProfileScreen();
          //       }),
          //     );
          //   },
          //   icon: const Icon(
          //     Icons.person,
          //     color: Palette.greenColor,
          //     size: 30,
          //   ),
          // ),
          CustomTextStyle(
            text: 'Your Doorstep',
            size: 36,
            fontWeight: FontWeight.bold,
            color: Palette.greenColor,
          ),
        ],
      ),
    );
  }
}
