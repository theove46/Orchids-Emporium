// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/home_products.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/main_products.dart';

class CatagoryText extends StatefulWidget {
  const CatagoryText({super.key});

  @override
  State<CatagoryText> createState() => _CatagoryTextState();
}

class _CatagoryTextState extends State<CatagoryText> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('categories')
        .orderBy('order')
        .snapshots();

    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextStyle(
            text: 'Catagories',
            size: 20,
            fontWeight: FontWeight.bold,
            color: Palette.greenColor,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return SizedBox(
                height: 40,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6, //snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      final categoryData = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ActionChip(
                            label: Text(categoryData['categoryName']),
                            labelStyle: GoogleFonts.ubuntu(
                              fontSize: 16,
                              color: Palette.whiteColor,
                            ),
                            backgroundColor: Palette.greenColor,
                            onPressed: () {
                              setState(() {
                                _selectedCategory =
                                    categoryData['categoryName'];
                              });
                              //print(_selectedCategory);
                            }),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
          if (_selectedCategory == null || _selectedCategory == 'All')
            const MainProductsWidgets()
          else
            HomeProductsWidgets(categoryName: _selectedCategory!)
        ],
      ),
    );
  }
}
