import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class NavItemsVendors {
  final String? title;
  final Icon? icon;

  NavItemsVendors(this.title, this.icon);
  static getdata() {}
}

List<TabItem> navItemsVendors = [
  const TabItem(
    icon: CupertinoIcons.money_dollar,
    title: 'Earnings',
  ),
  const TabItem(
    icon: Icons.upload,
    title: 'Upload',
  ),
  const TabItem(
    icon: Icons.edit,
    title: 'Edit',
  ),
  const TabItem(
    icon: Icons.shopping_cart_sharp,
    title: 'Orders',
  ),
  const TabItem(
    icon: Icons.logout,
    title: 'Logout',
  ),
  const TabItem(
    icon: Icons.account_box_sharp,
    title: 'Profile',
  ),
];
