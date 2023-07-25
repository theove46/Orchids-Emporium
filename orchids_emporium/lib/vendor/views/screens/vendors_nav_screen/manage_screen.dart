import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/vendor/views/screens/edit_products_tabs/published_tab.dart';
import 'package:orchids_emporium/vendor/views/screens/edit_products_tabs/unpublished_tab.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.whiteColor,
          iconTheme: const IconThemeData(
            color: Palette.greenColor,
          ),
          title: const CustomTextStyle(
            text: 'Manage Products',
            size: 24,
            fontWeight: FontWeight.bold,
            color: Palette.greenColor,
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Palette.greenColor,
            tabs: [
              Tab(
                child: CustomTextStyle(
                  text: 'Published',
                  size: 12,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
              ),
              Tab(
                child: CustomTextStyle(
                  text: 'Unpublished',
                  size: 12,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTabs(),
            UnPublishedTabs(),
          ],
        ),
        bottomSheet: Container(
          height: 60,
          width: double.infinity,
          color: Palette.greenColor,
        ),
      ),
    );
  }
}
