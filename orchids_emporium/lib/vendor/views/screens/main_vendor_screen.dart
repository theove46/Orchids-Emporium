// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/nav_bar_vendor_items.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/vendor/views/auth/vendor_auth.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/earning_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/manage_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/order_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/profile_screen_vendor.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Widget> _pages = [
    const EarningScreen(),
    UploadScreen(),
    const EditScreen(),
    VendorOrderScreen(),
    const VendorProfileScreen(),
  ];

  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedInVendor();
  }

  void _checkLoggedInVendor() async {
    if (_auth.currentUser == null) {
      await Future.delayed(const Duration(milliseconds: 10));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const VendorAuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(_pages.length, (index) => _pages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: navItemsVendors,
        color: Palette.whiteColor,
        notchColor: Palette.whiteColor,
        showLabel: true,
        showShadow: true,
        itemLabelStyle: GoogleFonts.ubuntu(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
        removeMargins: true,
        bottomBarWidth: 500,
        durationInMilliSeconds: 100,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
