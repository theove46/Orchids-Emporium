import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/catagories_screen.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/orders_screen.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/products_screen.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = VendorsScreen();
        });
        break;

      case OrdersScreen.routeName:
        setState(() {
          _selectedItem = OrdersScreen();
        });
        break;

      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });
        break;

      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;

      case ProductsScreen.routeName:
        setState(() {
          _selectedItem = ProductsScreen();
        });
        break;

      case UploadBanner.routeName:
        setState(() {
          _selectedItem = UploadBanner();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Palette.whiteColor,
        appBar: AppBar(
          backgroundColor: Palette.greenColor,
          centerTitle: true,
          title: Text(
            'The Orchids Emporium',
            style: GoogleFonts.ubuntu(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Palette.whiteColor,
              letterSpacing: 3,
            ),
          ),
        ),
        sideBar: SideBar(
          backgroundColor: Palette.whiteColor,
          activeIconColor: Palette.greenColor,
          iconColor: Palette.greenColor,
          borderColor: Palette.greenColor,
          textStyle: GoogleFonts.ubuntu(
            fontSize: 14,
            color: Palette.greenColor,
          ),
          items: [
            AdminMenuItem(
              title: 'Dashboard',
              icon: Icons.dashboard,
              route: DashboardScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Banners',
              icon: Icons.image,
              route: UploadBanner.routeName,
            ),
            AdminMenuItem(
              title: 'Categories',
              icon: Icons.view_list_rounded,
              route: CategoriesScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Vendors',
              icon: CupertinoIcons.person_2_fill,
              route: VendorsScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Products',
              icon: Icons.shop_2,
              route: ProductsScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Orders',
              icon: CupertinoIcons.cart_fill,
              route: OrdersScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Withdrawal',
              icon: CupertinoIcons.money_dollar_circle_fill,
              route: WithdrawalScreen.routeName,
            ),
          ],
          selectedRoute: '',
          onSelected: (item) {
            screenSelector(item);
          },
          header: Container(
            height: MediaQuery.of(context).size.height * .1,
            width: double.infinity,
            color: Palette.whiteColor,
            child: Center(
              child: CustomTextStyle(
                text: "Admin Panel",
                size: 26,
                fontWeight: FontWeight.bold,
                color: Palette.greenColor,
              ),
            ),
          ),
          footer: Container(
            padding: EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * .3,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/footerBanner.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: _selectedItem);
  }
}
