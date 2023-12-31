// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/vendor/views/screens/vendor_product_details/vendor_product_details_screen.dart';

class PublishedTabs extends StatelessWidget {
  PublishedTabs({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorProductsStream = FirebaseFirestore
        .instance
        .collection('products')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('approved', isEqualTo: true)
        .snapshots();

    return Material(
      color: Palette.secondary,
      child: StreamBuilder<QuerySnapshot>(
        stream: _vendorProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_sharp,
                    size: 80,
                    color: Palette.primary,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'No published\nproducts',
                    style: AppTypography.bold24(
                      color: Palette.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              final vendorProductsData = snapshot.data!.docs[index];
              return Slidable(
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('products')
                            .doc(vendorProductsData['productId'])
                            .update({
                          'approved': false,
                        });
                      },
                      flex: 2,
                      backgroundColor: Palette.primary,
                      foregroundColor: Palette.secondary,
                      icon: Icons.remove_shopping_cart_sharp,
                      label: 'Unpublish',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('products')
                            .doc(vendorProductsData['productId'])
                            .delete();
                      },
                      flex: 2,
                      backgroundColor: Palette.red,
                      foregroundColor: Palette.secondary,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return VendorProductDetailsScreen(
                          productData: vendorProductsData,
                        );
                      }),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  vendorProductsData['imageUrl'][0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendorProductsData['productName'],
                                style: AppTypography.bold20(),
                              ),
                              Text(
                                '৳ ${vendorProductsData['productPrice'].toStringAsFixed(2)}',
                                style: AppTypography.bold16(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
