// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: _cartProvider.getCartItem.isNotEmpty
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Text(
              'Carts',
              style: AppTypography.bold24(),
            ),
            if (_cartProvider.getCartItem.isNotEmpty)
              IconButton(
                icon: const Icon(
                  CupertinoIcons.delete,
                  color: Palette.greenColor,
                ),
                onPressed: () {
                  _cartProvider.removeAllItem();
                },
              )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: _cartProvider.getCartItem.isNotEmpty
                    ? ListView.builder(
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
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  cartData.imageUrl[0]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartData.productName.length > 20
                                                  ? '${cartData.productName.substring(0, 20)}...'
                                                  : cartData.productName,
                                              style: AppTypography.bold20(),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              '৳ ${cartData.price.toStringAsFixed(2)}',
                                              style: AppTypography.bold16(),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Palette.greenColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed:
                                                              cartData.quantity ==
                                                                      1
                                                                  ? null
                                                                  : () {
                                                                      _cartProvider
                                                                          .decreament(
                                                                              cartData);
                                                                    },
                                                          icon: const Icon(
                                                            Icons.remove,
                                                            color: Palette
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            cartData.quantity
                                                                .toString(),
                                                            style: AppTypography
                                                                .regular16(
                                                              color: Palette
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed: cartData
                                                                      .productQuantity ==
                                                                  cartData
                                                                      .quantity
                                                              ? null
                                                              : () {
                                                                  _cartProvider
                                                                      .increament(
                                                                          cartData);
                                                                },
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color: Palette
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    _cartProvider.removeItem(
                                                        cartData.productId);
                                                  },
                                                  icon: const Icon(
                                                    CupertinoIcons.delete,
                                                    color: Palette.greenColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              size: 80,
                              color: Palette.greenColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Your cart is empty',
                              style: AppTypography.bold36(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    (_cartProvider.getCartItem.isNotEmpty)
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
                                        return const CheckoutScreen();
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Palette.greenColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Checkout:  ৳ ${_cartProvider.totalPrice.toStringAsFixed(2)}',
                                  style: AppTypography.bold24(
                                    color: Palette.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
