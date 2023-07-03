// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

class LogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          await _auth.signOut();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Palette.greenColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: const CustomTextStyle(
          text: 'Signout',
          color: Palette.whiteColor,
        ),
      ),
    );
  }
}
