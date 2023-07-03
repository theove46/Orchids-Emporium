// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String title;
  const SquareTile({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 40,
          ),
          const SizedBox(width: 20),
          CustomTextStyle(
            text: title,
            size: 20,
            fontWeight: FontWeight.bold,
            color: Palette.greenColor,
          ),
        ],
      ),
    );
  }
}
