// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/product_details_screen.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key, required this.categoryData});
  final dynamic categoryData;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream;
    if (categoryData['categoryName'] != 'All') {
      _productStream = FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: categoryData['categoryName'])
          .where('approved', isEqualTo: true)
          .snapshots();
    } else {
      _productStream = FirebaseFirestore.instance
          .collection('products')
          .where('approved', isEqualTo: true)
          .snapshots();
    }

    return Scaffold(
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.whiteColor,
        iconTheme: const IconThemeData(
          color: Palette.greenColor,
        ),
        title: Text(
          categoryData['categoryName'],
          style: AppTypography.bold20(
            color: Palette.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

          return Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: double.infinity,
              //height: 900,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ProductDetailsScreen(
                            productData: productData,
                          );
                        }),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: Palette.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(productData['imageUrl'][0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                productData['productName'],
                                style: AppTypography.bold24(
                                  color: Palette.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '৳ ${productData['productPrice'].toStringAsFixed(2)}',
                                    style: AppTypography.bold16(),
                                  ),

                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: const Icon(
                                  //     Icons.favorite,
                                  //     color: Palette.greenColor,
                                  //   ),
                                  //   padding: EdgeInsets.zero,
                                  //   constraints: const BoxConstraints(),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
