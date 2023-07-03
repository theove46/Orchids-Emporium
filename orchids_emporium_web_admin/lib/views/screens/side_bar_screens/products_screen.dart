import 'package:flutter/material.dart';
import 'package:orchids_emporium_web_admin/core/rowHeader.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = '\ProductsScreen';

  // Widget _rowHeader(String text, int flex) {
  //   return Expanded(
  //       flex: flex,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Pallete.whiteColor),
  //           color: Pallete.greenColor,
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             text,
  //             style: GoogleFonts.ubuntu(
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //               color: Pallete.whiteColor,
  //             ),
  //           ),
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10),
            child: CustomTextStyle(
              text: 'Products',
              size: 36,
              fontWeight: FontWeight.bold,
              color: Palette.greenColor,
            ),
          ),
          Row(
            children: [
              rowHeader('IMAGE', 1),
              rowHeader('PRODUCT', 3),
              rowHeader('PRICE', 2),
              rowHeader('QUANTITY', 2),
              rowHeader('ACTION', 1),
              rowHeader('DETAILS', 1),
            ],
          )
        ],
      ),
    );
  }
}
