// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/core/widgets/primary_snackbar.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/users/view/users_nav_screens/cart_screen.dart';
import 'package:orchids_emporium/users/view/users_inner_screens/profile_screen_user.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.productData,
  }) : super(key: key);
  final dynamic productData;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String formatedDate() {
    final outputDateFormate = DateFormat('dd,MM,yyyy');
    final shippingDate = DateTime.now().add(const Duration(days: 3));
    final outputDate = outputDateFormate.format(shippingDate);
    return outputDate;
  }

  late PageController _pageController;
  int _currentPageIndex = 0;
  bool isButtonPressed = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Palette.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.secondary,
        iconTheme: const IconThemeData(
          color: Palette.primary,
        ),
        title: Text(
          widget.productData['productName'],
          style: AppTypography.bold20(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfileScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.productData['imageUrl'].length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.productData['imageUrl'][index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.productData['imageUrl'].length,
                  effect: const JumpingDotEffect(
                    activeDotColor: Palette.primary,
                    dotColor: Palette.grey,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.productData['productName'],
                style: AppTypography.bold30(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '৳ ${widget.productData['productPrice'].toStringAsFixed(2)}',
                style: AppTypography.bold24(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Estimated Shipping Date:  ${formatedDate()}',
                style: AppTypography.regular16(),
              ),
            ),
            SizedBox(
              height: 180.h,
              child: SingleChildScrollView(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: AppTypography.regular20(),
                      ),
                    ],
                  ),
                  collapsedIconColor: Palette.primary,
                  iconColor: Palette.primary,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.productData['description'],
                        style: AppTypography.regular20(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Palette.secondary,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.store,
                        size: 32,
                        color: Palette.primary,
                      ),
                      onPressed: () {},
                    ),
                    ElevatedButton(
                      onPressed: _cartProvider.getCartItem
                              .containsKey(widget.productData['productId'])
                          ? () {
                              ShowSnackBarMessage.showErrorSnackBar(
                                message: 'Item has been already added in cart',
                                context: context,
                              );
                            }
                          : () {
                              _cartProvider.addProductToCart(
                                widget.productData['productName'],
                                widget.productData['productId'],
                                widget.productData['imageUrl'],
                                1,
                                widget.productData['quantity'],
                                widget.productData['productPrice'],
                                widget.productData['vendorId'],
                                widget.productData['brandName'],
                              );

                              ShowSnackBarMessage.showSuccessSnackBar(
                                message:
                                    '${widget.productData['productName']} has been added in cart successfully',
                                context: context,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _cartProvider.getCartItem
                              .containsKey(widget.productData['productId'])
                          ? Text(
                              'In cart',
                              style: AppTypography.regular16(
                                color: Palette.secondary,
                              ),
                            )
                          : Text(
                              'Add to cart',
                              style: AppTypography.regular16(
                                color: Palette.secondary,
                              ),
                            ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_cartProvider.getCartItem.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CartScreen();
                              },
                            ),
                          );
                        } else {
                          ShowSnackBarMessage.showErrorSnackBar(
                            message: 'Please add items to cart',
                            context: context,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Buy now',
                        style: AppTypography.regular16(
                          color: Palette.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
