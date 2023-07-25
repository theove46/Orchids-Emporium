// ignore_for_file: use_build_context_synchronously

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/nav_bar_user_items.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/auth/login_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/cart_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/category_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/profile_screen_user.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/search_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/stores_screen.dart';

class MainUserScreen extends StatefulWidget {
  const MainUserScreen({super.key});

  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(), // Corrected typo "CatagoryScreen" to "CategoryScreen"
    const StoresScreen(),
    const CartScreen(),
    const SearchScreen(),
    //UserProfileScreen(),
  ];

  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedInUser();
  }

  void _checkLoggedInUser() async {
    if (_auth.currentUser == null) {
      await Future.delayed(const Duration(milliseconds: 10));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      // body: _pages[_visit],
      // bottomNavigationBar: BottomBarDivider(
      //   titleStyle: GoogleFonts.ubuntu(
      //     fontSize: 10,
      //     fontWeight: FontWeight.bold,
      //     color: Palette.greenColor,
      //   ),
      //   items: navItemsUser,
      //   backgroundColor: Palette.whiteColor,
      //   color: Colors.grey,
      //   colorSelected: Palette.greenColor,
      //   indexSelected: _visit,
      //   onTap: (index) => setState(() {
      //     _visit = index;
      //   }),
      //   styleDivider: StyleDivider.top,
      // ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(_pages.length, (index) => _pages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: navItemsUser2,
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
      bottomSheet: Container(
        height: 60,
        width: double.infinity,
        color: Palette.greenColor,
      ),
    );
  }
}
