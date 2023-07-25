// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _catagoryList = [];

  _getCatagories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _catagoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCatagories();
    super.initState();
  }

  String formatedDate(date) {
    final outputDateFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return 'Enter product name';
              } else {
                return null;
              }
            }),
            onChanged: (value) {
              _productProvider.getFromData(productName: value);
            },
            cursorColor: Palette.greenColor,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              fillColor: Palette.whiteColor,
              filled: true,
              hintText: 'Enter product name',
              hintStyle: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Palette.greyColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return 'Enter product price';
              } else {
                return null;
              }
            }),
            onChanged: (value) {
              _productProvider.getFromData(
                productPrice: double.parse(value),
              );
            },
            cursorColor: Palette.greenColor,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              fillColor: Palette.whiteColor,
              filled: true,
              hintText: 'Enter product price',
              hintStyle: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Palette.greyColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return 'Enter product quantity';
              } else {
                return null;
              }
            }),
            onChanged: (value) {
              _productProvider.getFromData(
                quantity: int.parse(value),
              );
            },
            cursorColor: Palette.greenColor,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              fillColor: Palette.whiteColor,
              filled: true,
              hintText: 'Enter product quantity',
              hintStyle: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Palette.greyColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              fillColor: Palette.whiteColor,
              filled: true,
              hintText: 'Select category',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Palette.greyColor,
              ),
            ),
            items: _catagoryList.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _productProvider.getFromData(category: value);
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return 'Enter product description';
              } else {
                return null;
              }
            }),
            onChanged: (value) {
              _productProvider.getFromData(
                description: value,
              );
            },
            maxLines: 10,
            cursorColor: Palette.greenColor,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Palette.greenColor),
              ),
              fillColor: Palette.whiteColor,
              filled: true,
              hintText: 'Enter product description',
              hintStyle: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Palette.greyColor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
