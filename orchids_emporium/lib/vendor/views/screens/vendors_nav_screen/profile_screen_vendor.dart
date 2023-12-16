// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/vendor/models/vendor_user_models.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_auth_page.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_information_entry_page.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<VendorProfileScreen> {
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
          return const Text("Loading");
        }

        if (!snapshot.data!.exists) {
          return const VendorInformationEntryPage();
        }

        VendorUserModel vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        vendorUserModel.storeImage.toString(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      vendorUserModel.companyName.toString(),
                      style: AppTypography.bold36(),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      vendorUserModel.email.toString(),
                      style: AppTypography.regular20(),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Verified  ',
                          style: AppTypography.regular20(),
                        ),
                        const Icon(
                          Icons.verified,
                          color: Palette.primary,
                          size: 20.0,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Palette.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Palette.primary,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Phone:   ',
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Palette.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: vendorUserModel.phone.toString(),
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Palette.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Palette.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Palette.primary,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Phone:   ',
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Palette.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: vendorUserModel.phone.toString(),
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Palette.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Palette.secondary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Palette.primary,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'TIN:   ',
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Palette.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: vendorUserModel.taxNumber.toString(),
                              style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: Palette.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VendorAuthPage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Palette.primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
