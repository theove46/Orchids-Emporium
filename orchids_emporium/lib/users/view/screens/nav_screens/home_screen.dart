import 'package:flutter/material.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/home_page_widgets/banner_widget.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/home_page_widgets/catagory_text.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/home_page_widgets/search_input_widget.dart';
import 'package:orchids_emporium/users/view/screens/nav_screens/home_page_widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeTextWidget(),
          const SearchInputWidget(),
          BannerWidget(),
          const CatagoryText(),
        ],
      ),
    );
  }
}
