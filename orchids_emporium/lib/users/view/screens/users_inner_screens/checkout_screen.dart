// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium/users/view/screens/bkash_payment/pages/phone_number_page.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/edit_profile.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;
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
              title: Text(
                'Checkout',
                style: AppTypography.bold20(),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                ListView.builder(
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
                                    Text(
                                      cartData.productName.length > 20
                                          ? '${cartData.productName.substring(0, 20)}...'
                                          : cartData.productName,
                                      style: AppTypography.bold16(),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '৳ ${cartData.price.toStringAsFixed(2)}',
                                      style: AppTypography.bold16(),
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
                data['address'] == ''
                    ? Container(
                        color: Palette.whiteColor,
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5),
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
                            child: Text(
                              'Enter billing address',
                              style: AppTypography.bold24(
                                color: Palette.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Palette.whiteColor,
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5),
                          child: ElevatedButton(
                            onPressed: () async {
                              EasyLoading.show(status: 'Placing Order');
                              await Future.delayed(const Duration(seconds: 2));

                              totalPrice = 0.0;
                              _cartProvider.getCartItem.forEach(
                                (key, item) {
                                  totalPrice =
                                      totalPrice + item.price * item.quantity;
                                },
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BkashPhoneNumberPage(
                                      userData: data,
                                      totalPrice: totalPrice,
                                      // item: totalPrice,
                                    );
                                  },
                                ),
                              );
                              EasyLoading.dismiss();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Palette.greenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Place order',
                              style: AppTypography.bold24(
                                color: Palette.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
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
