import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/nav_bar_vendor_items.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/vendor/views/screens/nav_screen/earning_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/nav_screen/edit_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/nav_screen/logout_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/nav_screen/order_screen.dart';
import 'package:orchids_emporium/vendor/views/screens/nav_screen/profile_screen_vendor.dart';
import 'package:orchids_emporium/vendor/views/screens/nav_screen/upload_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  final List<Widget> _pages = [
    const EarningScreen(),
    UploadScreen(),
    const EditScreen(),
    const OrderScreen(),
    LogoutScreen(),
    const VendorProfileScreen(),
  ];

  int _visit = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      body: _pages[_visit],
      bottomNavigationBar: BottomBarDivider(
        titleStyle: GoogleFonts.ubuntu(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
        items: navItemsVendors,
        backgroundColor: Palette.whiteColor,
        color: Colors.grey,
        colorSelected: Palette.greenColor,
        indexSelected: _visit,
        onTap: (index) => setState(() {
          _visit = index;
        }),
        styleDivider: StyleDivider.top,
      ),
    );
  }
}
