// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/home_page/widgets/category_wise_products.dart';
import 'package:orchids_emporium/users/view/home_page/widgets/all_products.dart';

class HomeProducts extends StatefulWidget {
  const HomeProducts({super.key});

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('categories')
        .orderBy('order')
        .snapshots();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: AppTypography.bold20(),
          ),
          const SizedBox(
            height: 6,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text(
                  'Something went wrong',
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Palette.primary,
                  ),
                );
              }

              return SizedBox(
                height: 40.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: ((context, index) {
                    final categoryData = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Palette.primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categoryData['categoryName'],
                              style: AppTypography.regular14(
                                color: Palette.secondary,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCategory = categoryData['categoryName'];
                          });
                        },
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          if (_selectedCategory == null || _selectedCategory == 'All')
            const AllProducts()
          else
            CategoryWiseProducts(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
