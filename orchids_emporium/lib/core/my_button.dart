import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Palette.greenColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: CustomTextStyle(
            text: 'Continue',
            size: 26,
            color: Palette.whiteColor,
          ),
        ),
      ),
    );
  }
}

class MyButtonAgree extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButtonAgree({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onTap,
      onTap: () {
        onTap;
        //print('SignUp clicked');
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Palette.greenColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CustomTextStyle(
            text: text,
            size: 26,
            color: Palette.whiteColor,
          ),
        ),
      ),
    );
  }
}
