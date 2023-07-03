import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/nav_bar_user_items.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/cart_screen.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/ctagory_screen.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/home_screen.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/profile_screen_user.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/search_screen.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/shop_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const CatagoryScreen(),
    const ShopScreen(),
    const CartScreen(),
    const SearchScreen(),
    UserProfileScreen(),
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
        items: navItemsUser,
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
