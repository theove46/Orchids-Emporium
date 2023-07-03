import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';

Widget rowHeader(String text, int flex) {
  return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.whiteColor),
          color: Palette.greenColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.ubuntu(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Palette.whiteColor,
            ),
          ),
        ),
      ));
}
