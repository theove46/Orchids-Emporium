import 'package:flutter/material.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName = '\WithdrawalScreen';

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
              text: 'Withdrawal',
              size: 36,
              fontWeight: FontWeight.bold,
              color: Palette.greenColor,
            ),
          ),
          Row(
            children: [
              _rowHeader('NAME', 1),
              _rowHeader('AMOUNT', 3),
              _rowHeader('BANK', 2),
              _rowHeader('ACCOUNT', 2),
              _rowHeader('EMAIL', 1),
              _rowHeader('PHONE', 1),
            ],
          )
        ],
      ),
    );
  }
}
