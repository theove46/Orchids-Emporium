import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:orchids_emporium/core/palette.dart';

List<BottomBarItem> navItemsVendors = [
  const BottomBarItem(
    inActiveItem: Icon(
      CupertinoIcons.money_dollar,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      CupertinoIcons.money_dollar,
      color: Palette.greenColor,
      size: 30,
    ),
    itemLabel: 'Earnings',
  ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.upload,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.upload,
      color: Palette.greenColor,
      size: 30,
    ),
    itemLabel: 'Upload',
  ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.edit_note,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.edit_note,
      color: Palette.greenColor,
      size: 30,
    ),
    itemLabel: 'Manage',
  ),
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
    itemLabel: 'Orders',
  ),
  const BottomBarItem(
    inActiveItem: Icon(
      Icons.account_box_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    activeItem: Icon(
      Icons.account_box_sharp,
      color: Palette.greenColor,
      size: 30,
    ),
    itemLabel: 'Profile',
  ),
];
