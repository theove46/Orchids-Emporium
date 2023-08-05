// ignore_for_file: use_build_context_synchronously

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/nav_bar_user_items.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/users/view/auth/sign_in_page/pages/user_sign_in_page.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/cart_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/category_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/search_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/stores_screen.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
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
        MaterialPageRoute(builder: (context) => const UserSignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Palette.whiteColor,
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(_pages.length, (index) => _pages[index]),
          ),
          extendBody: true,
          bottomNavigationBar: AnimatedNotchBottomBar(
            notchBottomBarController: _controller,
            bottomBarItems: navItemsUser,
            color: Palette.whiteColor,
            notchColor: Palette.greenColor,
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
        ),
      ),
    );
  }
}
