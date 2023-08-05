// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonTitle;
  final VoidCallback buttonFunction;
  final double borderRadius;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double fontSize;
  bool outlined;

  CustomButton({
    super.key,
    required this.buttonTitle,
    required this.buttonFunction,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 16.0,
    this.outlined = false,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return outlined
        ? OutlinedButton(
            onPressed: buttonFunction,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              side: BorderSide(color: borderColor!),
            ),
            child: buttonTitle,
            // Text(
            //         buttonTitle,
            //         style: GoogleFonts.ubuntu(fontSize: fontSize, color: textColor),
            //       ),
          )
        : ElevatedButton(
            onPressed: buttonFunction,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(double.maxFinite, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: buttonTitle,
            // Text(
            //   buttonTitle,
            //   style: GoogleFonts.ubuntu(
            //     fontSize: fontSize,
            //     color: textColor,
            //   ),
            // ),
          );
  }
}
