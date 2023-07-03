import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class NavItemsUser {
  final String? title;
  final Icon? icon;

  NavItemsUser(this.title, this.icon);
  static getdata() {}
}

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
    title: 'Shop',
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
