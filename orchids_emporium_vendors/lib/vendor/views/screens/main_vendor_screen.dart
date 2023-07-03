import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium_vendors/core/palette.dart';
import 'package:orchids_emporium_vendors/core/custom_textstyle.dart';

class MainVendorScreen extends StatelessWidget {
  const MainVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.greenColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: CustomTextStyle(
                text: 'Signout',
                color: Palette.whiteColor,
              ),
            ),
          ],
          // children: [
          //   CircleAvatar(
          //     radius: 60,
          //     backgroundImage: NetworkImage(
          //       vendorUserModel.storeImage.toString(),
          //     ),
          //   ),
          //   SizedBox(height: 16.0),
          //   Icon(
          //     Icons.verified,
          //     color: Palette.greenColor,
          //     size: 24.0,
          //   ),
          //   SizedBox(height: 16.0),
          //   CustomTextStyle(
          //     vendorUserModel.companyName.toString(),
          //     36,
          //     true,
          //     Palette.blackColor,
          //   ),
          //   SizedBox(height: 8.0),
          //   CustomTextStyle(
          //     '${vendorUserModel.countryValue.toString()}',
          //     16,
          //     false,
          //     Palette.blackColor,
          //   ),
          //   SizedBox(height: 8.0),
          //   CustomTextStyle(
          //     '${vendorUserModel.cityValue.toString()}, ${vendorUserModel.stateValue.toString()}',
          //     16,
          //     false,
          //     Palette.blackColor,
          //   ),
          //   SizedBox(height: 16.0),
          //   CustomTextStyle(
          //     vendorUserModel.email.toString(),
          //     16,
          //     false,
          //     Palette.blackColor,
          //   ),
          //   SizedBox(height: 8.0),
          //   CustomTextStyle(
          //     vendorUserModel.phone.toString(),
          //     16,
          //     false,
          //     Palette.blackColor,
          //   ),
          //   SizedBox(height: 16.0),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       CustomTextStyle(
          //         'Tax Registered: ',
          //         16,
          //         false,
          //         Palette.blackColor,
          //       ),
          //       Icon(
          //         Icons.check_circle,
          //         color: Palette.greenColor,
          //       ),
          //     ],
          //   ),
          //   SizedBox(height: 8.0),
          //   CustomTextStyle(
          //     vendorUserModel.taxNumber.toString(),
          //     16,
          //     false,
          //     Palette.blackColor,
          //   ),
          //   SizedBox(height: 16.0),
          //   ElevatedButton(
          //     onPressed: () async {
          //       await _auth.signOut();
          //     },
          //     style: ButtonStyle(
          //       backgroundColor:
          //           MaterialStateProperty.all<Color>(Palette.greenColor),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //       ),
          //     ),
          //     child: CustomTextStyle(
          //       'Signout',
          //       16,
          //       false,
          //       Palette.whiteColor,
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
