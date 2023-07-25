import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:orchids_emporium/core/palette.dart';

List<TabItem> navItemsUser = [
  const TabItem(
    icon: Icons.home_sharp,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.list_alt_sharp,
    title: 'Catagories',
  ),
  const TabItem(
    icon: Icons.shopping_bag_sharp,
    title: 'Stores',
  ),
  // TabItem(
  //   icon: Icons.favorite_border,
  //   title: 'Wishlist',
  // ),
  const TabItem(
    icon: Icons.shopping_cart_sharp,
    title: 'Cart',
  ),
  const TabItem(
    icon: Icons.search_sharp,
    title: 'Search',
  ),
  const TabItem(
    icon: Icons.person,
    title: 'Profile',
  ),
];

List<BottomBarItem> navItemsUser2 = [
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.home_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.home_sharp,
      color: Palette.greenColor,
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
      color: Palette.greenColor,
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
      color: Palette.greenColor,
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
      color: Palette.greenColor,
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
      color: Palette.greenColor,
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
