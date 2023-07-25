// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/edit_profile.dart';
import 'package:orchids_emporium/users/view/screens/main_user_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
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
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Palette.whiteColor,
              iconTheme: const IconThemeData(
                color: Palette.greenColor,
              ),
              title: const CustomTextStyle(
                text: 'Checkout',
                size: 20,
                fontWeight: FontWeight.bold,
                color: Palette.greenColor,
              ),
              centerTitle: true,
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 5,
                    color: Palette.greenwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(cartData.imageUrl[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextStyle(
                                  text: cartData.productName.length > 20
                                      ? '${cartData.productName.substring(0, 20)}...'
                                      : cartData.productName,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.greenColor,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                CustomTextStyle(
                                  text:
                                      '৳ ${cartData.price.toStringAsFixed(2)}',
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.greenColor,
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Palette.greenColor),
                                    backgroundColor: Palette.greenColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: CustomTextStyle(
                                    text: cartData.productSize,
                                    size: 12,
                                    color: Palette.whiteColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomSheet: data['address'] == ''
                ? Container(
                    color: Palette.whiteColor,
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditProfileScreen(
                                  userData: data,
                                );
                              },
                            ),
                          ).whenComplete(() {
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const CustomTextStyle(
                          text: 'Enter billing address',
                          size: 24,
                          fontWeight: FontWeight.bold,
                          color: Palette.whiteColor,
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Palette.whiteColor,
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          EasyLoading.show(status: 'Placing Order');
                          _cartProvider.getCartItem.forEach((key, item) {
                            final orderId = const Uuid().v4();
                            _firestore.collection('orders').doc(orderId).set({
                              'orderId': orderId,
                              'vendorId': item.vendorId,
                              'buyerEmail': data['email'],
                              'buyerPhone': data['phone'],
                              'buyerAddress': data['address'],
                              'buyerId': data['buyerId'],
                              'buyerName': data['fullName'],
                              'buyerPhoto': data['profileImage'],
                              'productName': item.productName,
                              'productPrice': item.price,
                              'productImage': item.imageUrl,
                              'productId': item.productId,
                              'productSize': item.productSize,
                              'quantity': item.quantity,
                              'orderDate': DateTime.now(),
                              'accepted': false,
                            }).whenComplete(() {
                              setState(() {
                                _cartProvider.getCartItem.clear();
                              });
                              EasyLoading.dismiss();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const MainUserScreen();
                                  },
                                ),
                              );
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const CustomTextStyle(
                          text: 'Place order',
                          size: 24,
                          fontWeight: FontWeight.bold,
                          color: Palette.whiteColor,
                        ),
                      ),
                    ),
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