// ignore_for_file: use_build_context_synchronously

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/nav_bar_user_items.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/authentication_user/sign_in_page/pages/user_sign_in_page.dart';
import 'package:orchids_emporium/users/view/users_inner_screens/profile_screen_user.dart';
import 'package:orchids_emporium/users/view/users_nav_screens/cart_screen.dart';
import 'package:orchids_emporium/users/view/users_nav_screens/category_screen.dart';
import 'package:orchids_emporium/users/view/home_page/pages/home_page.dart';
import 'package:orchids_emporium/users/view/users_nav_screens/search_screen.dart';
import 'package:orchids_emporium/users/view/users_nav_screens/stores_screen.dart';

class UserDashBoardPage extends StatefulWidget {
  const UserDashBoardPage({super.key});

  @override
  State<UserDashBoardPage> createState() => _UserDashBoardPageState();
}

class _UserDashBoardPageState extends State<UserDashBoardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List _pages = [
    const HomePage(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    const SearchScreen(),
    UserProfileScreen(),
  ];

  final _pageController = PageController(initialPage: 0);
  int maxCount = 6;
  int _visit = 0;

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
      await Future.delayed(
        const Duration(milliseconds: 10),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserSignInPage(),
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
      items: navItemsUser,
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
