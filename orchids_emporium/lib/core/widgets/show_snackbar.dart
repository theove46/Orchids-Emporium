import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Palette.greenColor,
      content: Text(
        title,
        style: AppTypography.regular16(
          color: Palette.whiteColor,
        ),
      ),
    ),
  );
}
