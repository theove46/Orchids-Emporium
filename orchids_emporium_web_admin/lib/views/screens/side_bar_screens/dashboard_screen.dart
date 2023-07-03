import 'package:flutter/material.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '\DashboardScreen';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: CustomTextStyle(
          text: 'Dashboard',
          size: 36,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
      ),
    );
  }
}
