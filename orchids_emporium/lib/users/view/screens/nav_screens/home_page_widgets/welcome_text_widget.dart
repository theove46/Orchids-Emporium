// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          bottom: 10,
          left: 14,
          right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextStyle(
                text: 'Bringing Nature to',
                size: 28,
                fontWeight: FontWeight.bold,
                color: Palette.greenColor,
              ),
              Container(
                child: const Icon(
                  Icons.shopping_cart_sharp,
                  color: Palette.greenColor,
                  size: 30,
                ),
              ),
            ],
          ),
          const CustomTextStyle(
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
