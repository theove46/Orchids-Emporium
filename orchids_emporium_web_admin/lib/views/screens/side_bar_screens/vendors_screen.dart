import 'package:flutter/material.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/widgets/vendor_widget.dart';

class VendorsScreen extends StatelessWidget {
  static const String routeName = '\VendorsScreen';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Palette.whiteColor),
            color: Palette.greenColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextStyle(
              text: text,
              size: 14,
              fontWeight: FontWeight.bold,
              color: Palette.whiteColor,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: CustomTextStyle(
              text: 'Vendors',
              size: 36,
              fontWeight: FontWeight.bold,
              color: Palette.greenColor,
            ),
          ),
          Row(
            children: [
              _rowHeader('LOGO', 1),
              _rowHeader('COMPANY', 3),
              _rowHeader('CITY', 2),
              _rowHeader('DIVISION', 2),
              _rowHeader('ACTION', 1),
              _rowHeader('DETAILS', 1),
            ],
          ),
          VendorWidget(),
        ],
      ),
    );
  }
}
