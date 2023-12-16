// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/nav_bar_vendor_items.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_auth_page.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/earning_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/manage_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/order_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/profile_screen_vendor.dart';
import 'package:orchids_emporium/vendor/views/screens/vendors_nav_screen/upload_screen.dart';

class VendorDashboardPage extends StatefulWidget {
  const VendorDashboardPage({super.key});

  @override
  State<VendorDashboardPage> createState() => _VendorDashboardPageState();
}

class _VendorDashboardPageState extends State<VendorDashboardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Widget> _pages = [
    const EarningScreen(),
    UploadScreen(),
    const EditScreen(),
    VendorOrderScreen(),
    const VendorProfileScreen(),
  ];

  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;
  int _visit = 0;

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
      await Future.delayed(
        const Duration(milliseconds: 10),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const VendorAuthPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Palette.secondary,
          body: _pages[_visit],
          bottomNavigationBar: _buildBottomBarDivider(),
        ),
      ),
    );
  }

  Widget _buildBottomBarDivider() {
    return BottomBarDivider(
      titleStyle: AppTypography.bold10(
        color: Palette.secondary,
      ),
      items: navItemsVendors,
      backgroundColor: Palette.secondary,
      color: Colors.grey,
      colorSelected: Palette.primary,
      indexSelected: _visit,
      onTap: (index) => setState(() {
        _visit = index;
      }),
      styleDivider: StyleDivider.top,
    );
  }
}
