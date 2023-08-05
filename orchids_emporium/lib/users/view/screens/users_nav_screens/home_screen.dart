import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/banner_widget.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/catagory_text.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/home_page_widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeTextWidget(),
          BannerWidget(),
          const CatagoryText(),
          //const SizedBox(height: 10),
        ],
      ),
    );
  }
}
