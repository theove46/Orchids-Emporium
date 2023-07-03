// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';

// Widget UbuntuText(String text, double size, bool bold, Color color) {
//     return Text(
//       text,
//       style: GoogleFonts.ubuntu(
//         fontSize: size,
//         fontWeight: bold==true? FontWeight.bold : FontWeight.normal,
//         color: color,
//       ),
//     );
//   }

class CustomTextStyle extends StatelessWidget {
  const CustomTextStyle({
    Key? key,
    required this.text,
    this.size = 16,
    this.color = Palette.blackColor,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);
  final String text;
  final double size;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
