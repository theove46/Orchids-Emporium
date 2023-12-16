// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/users/view/users_inner_screens/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        _topBar(_cartProvider),
        SizedBox(
          height: 750.h,
          child: Column(
            mainAxisAlignment: _cartProvider.getCartItem.isNotEmpty
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.center,
            children: [
              _cartProvider.getCartItem.isNotEmpty
                  ? _buildCartList(_cartProvider)
                  : _buildCartItemsEmpty(),
              const SizedBox(height: 10),
              (_cartProvider.getCartItem.isNotEmpty)
                  ? _buildButton(context, _cartProvider)
                  : Container(
                      height: 50.h,
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCartList(CartProvider _cartProvider) {
    return SizedBox(
      height: 680.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _cartProvider.getCartItem.length,
        itemBuilder: (context, index) {
          final cartData = _cartProvider.getCartItem.values.toList()[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
                elevation: 5,
                color: Palette.greenWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Palette.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          onPressed: cartData.quantity == 1
                                              ? null
                                              : () {
                                                  _cartProvider
                                                      .decreament(cartData);
                                                },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Palette.secondary,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            cartData.quantity.toString(),
                                            style: AppTypography.regular16(
                                              color: Palette.secondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: cartData.productQuantity ==
                                                  cartData.quantity
                                              ? null
                                              : () {
                                                  _cartProvider
                                                      .increament(cartData);
                                                },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Palette.secondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _cartProvider
                                        .removeItem(cartData.productId);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.delete,
                                    color: Palette.primary,
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
      ),
    );
  }

  Widget _buildButton(BuildContext context, CartProvider _cartProvider) {
    return Container(
      color: Palette.secondary,
      height: 50.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
            backgroundColor: Palette.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Checkout:  ৳ ${_cartProvider.totalPrice.toStringAsFixed(2)}',
            style: AppTypography.bold20(
              color: Palette.secondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(CartProvider _cartProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            CupertinoIcons.app_fill,
            color: Palette.secondary,
          ),
          Text(
            'Carts',
            style: AppTypography.bold24(),
          ),
          IconButton(
            icon: Icon(
              CupertinoIcons.delete,
              color: _cartProvider.getCartItem.isNotEmpty
                  ? Palette.primary
                  : Palette.secondary,
            ),
            onPressed: () {
              if (_cartProvider.getCartItem.isNotEmpty) {
                _cartProvider.removeAllItem();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildCartItemsEmpty() {
    return Column(
      children: [
        const Icon(
          Icons.shopping_cart,
          size: 80,
          color: Palette.primary,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Your cart is empty',
          style: AppTypography.bold36(),
        ),
      ],
    );
  }
}
