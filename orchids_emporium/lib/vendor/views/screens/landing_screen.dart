import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/vendor/models/vendor_user_models.dart';
import 'package:orchids_emporium/vendor/views/auth/vendor_registration_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/main_vendor_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (!snapshot.data!.exists) {
            return VendorRegistrationScreen();
          }

          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (vendorUserModel.approved == true) {
            return const MainVendorScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextStyle(
                  text: 'Orchids Emporium',
                  size: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
                const SizedBox(height: 16.0),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    vendorUserModel.storeImage.toString(),
                  ),
                ),
                const SizedBox(height: 16.0),
                CustomTextStyle(
                  text: 'Hello ${vendorUserModel.companyName.toString()}',
                  size: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
                const SizedBox(height: 8.0),
                const CustomTextStyle(
                  text: 'Admin will get back to you soon',
                  size: 20,
                  color: Palette.greenColor,
                ),
                const SizedBox(height: 16.0),
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
                  child: const CustomTextStyle(
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
