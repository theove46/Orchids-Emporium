import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/users/view/home_page/widgets/banners.dart';
import 'package:orchids_emporium/users/view/home_page/widgets/home_products.dart';
import 'package:orchids_emporium/users/view/home_page/widgets/welcome_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const WelcomeText(),
          Banners(),
          const HomeProducts(),
        ],
      ),
    );
  }
}
