// ignore_for_file: unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/core/show_snackbar.dart';
import 'package:orchids_emporium/provider/cart_provider.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/cart_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/profile_screen_user.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.productData})
      : super(key: key);
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
  String? _selectedSize;
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
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.whiteColor,
        iconTheme: const IconThemeData(
          color: Palette.greenColor,
        ),
        title: CustomTextStyle(
          text: widget.productData['productName'],
          size: 20,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      activeDotColor: Palette.greenColor,
                      dotColor: Palette.greyColor,
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
                child: CustomTextStyle(
                  text: widget.productData['productName'],
                  size: 40,
                  color: Palette.greenColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextStyle(
                  text:
                      '৳ ${widget.productData['productPrice'].toStringAsFixed(2)}',
                  size: 32,
                  color: Palette.greenColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ExpansionTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextStyle(
                      text: 'Description',
                      size: 20,
                      color: Palette.greenColor,
                    ),
                  ],
                ),
                collapsedIconColor: Palette.greenColor,
                iconColor: Palette.greenColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextStyle(
                      text: widget.productData['description'],
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const CustomTextStyle(
                      text: 'Available size:  ',
                      color: Palette.greenColor,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['sizeList'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: OutlinedButton(
                              onPressed: () {
                                //isButtonPressed = !isButtonPressed;
                                if (!isButtonPressed) {
                                  setState(() {
                                    isButtonPressed = !isButtonPressed;
                                    _selectedSize =
                                        widget.productData['sizeList'][index];
                                  });
                                } else {
                                  setState(() {
                                    isButtonPressed = !isButtonPressed;
                                    _selectedSize = null;
                                  });
                                }
                                print(_selectedSize);
                              },
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Palette.greenColor),
                                backgroundColor: _selectedSize ==
                                        widget.productData['sizeList'][index]
                                    ? Palette.greenColor
                                    : Palette.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: CustomTextStyle(
                                text: widget.productData['sizeList'][index],
                                size: 16,
                                color: _selectedSize ==
                                        widget.productData['sizeList'][index]
                                    ? Palette.whiteColor
                                    : Palette.greenColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextStyle(
                  text: 'Estimated Shipping Date:  ${formatedDate()}',
                  color: Palette.greenColor,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Palette.whiteColor,
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
                  color: Palette.greenColor,
                ),
                onPressed: () {},
              ),
              ElevatedButton(
                onPressed: _cartProvider.getCartItem
                        .containsKey(widget.productData['productId'])
                    ? () {
                        showSnack(
                            context, 'Item has been already added in cart');
                      }
                    : () {
                        if (_selectedSize != null) {
                          _cartProvider.addProductToCart(
                            widget.productData['productName'],
                            widget.productData['productId'],
                            widget.productData['imageUrl'],
                            1,
                            widget.productData['quantity'],
                            widget.productData['productPrice'],
                            widget.productData['vendorId'],
                            _selectedSize!,
                            widget.productData['scheduleDate'],
                          );
                          showSnack(context,
                              '${widget.productData['productName']} has been added in cart successfully');
                        } else {
                          showSnack(context, 'Please select size');
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _cartProvider.getCartItem
                        .containsKey(widget.productData['productId'])
                    ? const CustomTextStyle(
                        text: 'In cart',
                        color: Palette.whiteColor,
                      )
                    : const CustomTextStyle(
                        text: 'Add to cart',
                        color: Palette.whiteColor,
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
                    showSnack(context, 'Please add items to cart');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.greenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const CustomTextStyle(
                  text: 'Buy now',
                  color: Palette.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
