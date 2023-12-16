// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/core/widgets/primary_snackbar.dart';
import 'package:orchids_emporium/provider/product_provider.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_dashboard_page.dart';
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
          backgroundColor: Palette.secondary,
          appBar: AppBar(
            backgroundColor: Palette.secondary,
            elevation: 0,
            title: Text(
              'Upload Products',
              style: AppTypography.bold24(),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Palette.primary,
              tabs: [
                Tab(
                  child: Text(
                    'General',
                    style: AppTypography.bold12(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Shipping',
                    style: AppTypography.bold12(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Attributes',
                    style: AppTypography.bold12(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Images',
                    style: AppTypography.bold12(),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 600.h,
                    child: const TabBarView(
                      children: [
                        GeneralScreen(),
                        ShippingScreen(),
                        AttributeTabScreen(),
                        ImagesTabScreen(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show(status: 'Uploading product');
                          final productId = const Uuid().v4();
                          await _firestore
                              .collection('products')
                              .doc(productId)
                              .set({
                            'productId': productId,
                            'productName':
                                _productProvider.productData['productName'],
                            'productPrice':
                                _productProvider.productData['productPrice'],
                            'quantity':
                                _productProvider.productData['quantity'],
                            'category':
                                _productProvider.productData['category'],
                            'description':
                                _productProvider.productData['description'],
                            'imageUrl':
                                _productProvider.productData['imageUrlList'],
                            'chargeShipping':
                                _productProvider.productData['chargeShipping'],
                            'shippingCharge':
                                _productProvider.productData['shippingCharge'],
                            'brandName':
                                _productProvider.productData['brandName'],
                            'vendorId': FirebaseAuth.instance.currentUser!.uid,
                            'approved': false,
                          }).whenComplete(() {
                            _productProvider.clearData();
                            _formKey.currentState!.reset();
                            EasyLoading.dismiss();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const VendorDashboardPage();
                                },
                              ),
                            );
                          });
                        } else {
                          ShowSnackBarMessage.showErrorSnackBar(
                            message: 'Please fill up all the fields',
                            context: context,
                          );
                        }
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
                        'Save product',
                        style: AppTypography.regular16(
                          color: Palette.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
