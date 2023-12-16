import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/vendor/models/vendor_user_models.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_information_entry_page.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_dashboard_page.dart';

class NotApprovedPage extends StatefulWidget {
  const NotApprovedPage({super.key});
  @override
  State<NotApprovedPage> createState() => _NotApprovedPageState();
}

class _NotApprovedPageState extends State<NotApprovedPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _vendorsStream =
      FirebaseFirestore.instance.collection('vendors');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Palette.primary,
            ),
          );
        }

        if (!snapshot.data!.exists) {
          return const VendorInformationEntryPage();
        }

        VendorUserModel vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);

        if (vendorUserModel.approved == true) {
          return const VendorDashboardPage();
        }
        return Container(
          color: Palette.secondary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Orchids Emporium',
                  style: AppTypography.bold36(),
                ),
                SizedBox(height: 16.h),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Palette.primary,
                  backgroundImage: NetworkImage(
                    vendorUserModel.storeImage.toString(),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Hello ${vendorUserModel.companyName.toString()}',
                  style: AppTypography.bold36(),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Admin will get back to you soon',
                  style: AppTypography.regular20(),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Palette.primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Signout',
                    style: AppTypography.regular16(
                      color: Palette.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
