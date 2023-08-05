// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            'Charge shipping',
            style: AppTypography.regular16(),
          ),
          activeColor: Palette.greenColor,
          value: _chargeShipping,
          onChanged: (value) {
            setState(() {
              _chargeShipping = value;
              _productProvider.getFromData(chargeShipping: _chargeShipping);
            });
          },
        ),
        if (_chargeShipping == true)
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return 'Enter shipping charge';
              } else {
                return null;
              }
            }),
            keyboardType: TextInputType.number,
            cursorColor: Palette.greenColor,
            onChanged: (value) {
              _productProvider.getFromData(
                shippingCharge: int.parse(value),
              );
            },
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              fillColor: Palette.whiteColor,
              filled: true,
              hintText: 'Shipping charge',
              hintStyle: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Palette.greyColor,
              ),
            ),
          ),
      ],
    );
  }
}
