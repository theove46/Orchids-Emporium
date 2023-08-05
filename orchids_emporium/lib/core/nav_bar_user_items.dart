import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';

List<BottomBarItem> navItemsUser = [
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.home_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.home_sharp,
      color: Palette.whiteColor,
      size: 30,
    ),
    itemLabel: 'Home',
  ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.list_alt_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.list_alt_sharp,
      color: Palette.whiteColor,
      size: 30,
    ),
    itemLabel: 'Categories',
  ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.shopping_bag_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.shopping_bag_sharp,
      color: Palette.whiteColor,
      size: 30,
    ),
    itemLabel: 'Stores',
  ),
  // TabItem(
  //   icon: Icons.favorite_border,
  //   title: 'Wishlist',
  // ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.shopping_cart_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.shopping_cart_sharp,
      color: Palette.whiteColor,
      size: 30,
    ),
    itemLabel: 'Cart',
  ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.search_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.search_sharp,
      color: Palette.whiteColor,
      size: 30,
    ),
    itemLabel: 'Search',
  ),
  // const BottomBarItem(
  //   inActiveItem: Icon(
  //     Icons.person,
  //     color: Palette.greenColor,
  //     size: 30,
  //   ),
  //   activeItem: Icon(
  //     Icons.person,
  //     color: Palette.greenColor,
  //     size: 30,
  //   ),
  //   itemLabel: 'Profile',
  // ),
];
