// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/core/show_snackbar.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_inner_screes/withdrawal_screen.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('vendors');

    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            backgroundColor: Palette.whiteColor,
            body: StreamBuilder<QuerySnapshot>(
              stream: _ordersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Palette.greenColor,
                    ),
                  );
                }

                double totalOrder = 0.0;
                for (var orderItem in snapshot.data!.docs) {
                  totalOrder +=
                      orderItem['quantity'] * orderItem['productPrice'];
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(data['storeImage']),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomTextStyle(
                                text: data['companyName'],
                                size: 36,
                                fontWeight: FontWeight.bold,
                                color: Palette.greenColor,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const CustomTextStyle(
                            text: 'Total Earnings:',
                            size: 24,
                            fontWeight: FontWeight.bold,
                            color: Palette.greenColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextStyle(
                            text: '৳ ${totalOrder.toStringAsFixed(2)}',
                            size: 36,
                            fontWeight: FontWeight.bold,
                            color: Palette.greenColor,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          const CustomTextStyle(
                            text: 'Total Orders:',
                            size: 24,
                            fontWeight: FontWeight.bold,
                            color: Palette.greenColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextStyle(
                            text: snapshot.data!.docs.length.toString(),
                            size: 36,
                            fontWeight: FontWeight.bold,
                            color: Palette.greenColor,
                          ),
                          const SizedBox(
                            height: 100,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const WithdrawalScreen();
                                    },
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Palette.greenColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const CustomTextStyle(
                                text: 'Withdraw',
                                color: Palette.whiteColor,
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
                );
              },
            ),
            bottomSheet: Container(
              height: 60,
              width: double.infinity,
              color: Palette.greenColor,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Palette.greenColor,
          ),
        );
      },
    );
  }
}
