import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
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
          title: Text(
            'Manage Products',
            style: AppTypography.bold24(),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Palette.greenColor,
            tabs: [
              Tab(
                child: Text(
                  'Published',
                  style: AppTypography.bold12(),
                ),
              ),
              Tab(
                child: Text(
                  'Unpublished',
                  style: AppTypography.bold12(),
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
