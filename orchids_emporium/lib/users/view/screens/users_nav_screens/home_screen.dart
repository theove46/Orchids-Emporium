import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/banner_widget.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/catagory_text.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        elevation: 0,
        actionsIconTheme: const IconThemeData(
          color: Palette.greenColor,
        ),
        title: const CustomTextStyle(
          text: 'Bringing Nature to',
          size: 28,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeTextWidget(),
            BannerWidget(),
            const CatagoryText(),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 60,
        width: double.infinity,
        color: Palette.greenColor,
      ),
      endDrawer: Drawer(
        width: 250,
        backgroundColor: Palette.whiteColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Palette.greenColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Picture',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Name',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
              ),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.pushNamed(context, Routes.updateProfile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text(
                'Wishlist',
              ),
              onTap: () {
                // Navigator.pop(context);
                // Navigator.pushNamed(context, Routes.changePassword);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'logout',
              ),
              onTap: () {
                // _logoutAndNavigate();
              },
            )
          ],
        ),
      ),
    );
  }
}
