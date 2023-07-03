import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Palette.greenColor,
    content: CustomTextStyle(
      text: title,
      color: Palette.whiteColor,
    ),
  ));
}
