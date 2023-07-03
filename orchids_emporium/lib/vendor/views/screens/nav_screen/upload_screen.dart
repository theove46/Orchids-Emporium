// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:orchids_emporium/vendor/views/screens/main_vendor_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/upload_tap_screens/attribute_tab_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/upload_tap_screens/general_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/upload_tap_screens/images_tab_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.greenColor,
            elevation: 0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: CustomTextStyle(
                    text: 'General',
                    size: 12,
                    fontWeight: FontWeight.bold,
                    color: Palette.whiteColor,
                  ),
                ),
                Tab(
                  child: CustomTextStyle(
                    text: 'Shipping',
                    size: 12,
                    fontWeight: FontWeight.bold,
                    color: Palette.whiteColor,
                  ),
                ),
                Tab(
                  child: CustomTextStyle(
                    text: 'Attributes',
                    size: 12,
                    fontWeight: FontWeight.bold,
                    color: Palette.whiteColor,
                  ),
                ),
                Tab(
                  child: CustomTextStyle(
                    text: 'Images',
                    size: 12,
                    fontWeight: FontWeight.bold,
                    color: Palette.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const GeneralScreen(),
              const ShippingScreen(),
              const AttributeTabScreen(),
              ImagesTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: ElevatedButton(
              onPressed: () async {
                EasyLoading.show(status: 'Uploading product');
                if (_formKey.currentState!.validate()) {
                  final productId = const Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'imageUrl': _productProvider.productData['imageUrlList'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'vendorId': FirebaseAuth.instance.currentUser!.uid,
                    'approved': false,
                  }).whenComplete(() {
                    _productProvider.clearData();
                    _formKey.currentState!.reset();
                    EasyLoading.dismiss();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MainVendorScreen();
                        },
                      ),
                    );
                  });
                }
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
                text: 'Save',
                color: Palette.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
