// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium_vendors/core/palette.dart';
import 'package:orchids_emporium_vendors/core/custom_textstyle.dart';
import 'package:orchids_emporium_vendors/vendor/models/vendor_user_models.dart';
import 'package:orchids_emporium_vendors/vendor/views/auth/vendor_registration_screen.dart';
import 'package:orchids_emporium_vendors/vendor/views/screens/main_vendor_screen.dart';
import 'package:rxdart/rxdart.dart';

class LandinScreen extends StatefulWidget {
  const LandinScreen({Key? key});

  @override
  State<LandinScreen> createState() => _LandinScreenState();
}

class _LandinScreenState extends State<LandinScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _vendorsStream =
      FirebaseFirestore.instance.collection('vendors');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (!snapshot.data!.exists) {
            return VendorRegistrationScreen();
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return MainVendorScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextStyle(
                  text: 'Orchids Emporium',
                  size: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
                SizedBox(height: 16.0),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    vendorUserModel.storeImage.toString(),
                  ),
                ),
                SizedBox(height: 16.0),
                CustomTextStyle(
                  text: 'Hello ${vendorUserModel.companyName.toString()}',
                  size: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
                SizedBox(height: 8.0),
                CustomTextStyle(
                  text: 'Admin will get back to you soon',
                  size: 20,
                  color: Palette.greenColor,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
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
            ),
          );
        },
      ),
    );
  }
}
