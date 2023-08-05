import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/auth/sign_in_page/pages/user_sign_in_page.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/profile_screen_user.dart';

class HomePageDrawer extends StatelessWidget {
  HomePageDrawer({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Drawer(
            width: 250,
            backgroundColor: Palette.whiteColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Palette.greenColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Palette.greenColor,
                          backgroundImage: NetworkImage(data['profileImage']),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          data['fullName'],
                          style: AppTypography.bold20(
                            color: Palette.whiteColor,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          data['email'],
                          style: AppTypography.bold16(
                            color: Palette.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Palette.greenColor,
                  ),
                  title: Text(
                    'Profile',
                    style: AppTypography.bold16(),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserProfileScreen();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.lock,
                    color: Palette.greenColor,
                  ),
                  title: Text(
                    'Wishlist',
                    style: AppTypography.bold16(),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Palette.greenColor,
                  ),
                  title: Text(
                    'Logout',
                    style: AppTypography.bold16(),
                  ),
                  onTap: () async {
                    await _auth.signOut().whenComplete(() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const UserSignInPage();
                          },
                        ),
                        (route) => false,
                      );
                    });
                  },
                )
              ],
            ),
          );

          // Scaffold(
          //   backgroundColor: Palette.whiteColor,
          //   body: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Center(
          //           child: CircleAvatar(
          //             radius: 64,
          //             backgroundColor: Palette.greenColor,
          //             backgroundImage: NetworkImage(data['profileImage']),
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         CustomTextStyle(
          //           text: data['fullName'],
          //           color: Palette.greenColor,
          //           fontWeight: FontWeight.bold,
          //           size: 24,
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         CustomTextStyle(
          //           text: data['email'],
          //           color: Palette.greenColor,
          //           size: 20,
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         SizedBox(
          //           height: 50,
          //           width: 200,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) {
          //                     return EditProfileScreen(
          //                       userData: data,
          //                     );
          //                   },
          //                 ),
          //               );
          //             },
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Palette.greenColor,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //             ),
          //             child: const CustomTextStyle(
          //               text: 'Edit profile',
          //               size: 24,
          //               fontWeight: FontWeight.bold,
          //               color: Palette.whiteColor,
          //             ),
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         const Divider(
          //           thickness: 1,
          //           color: Palette.greenColor,
          //         ),
          //         const ListTile(
          //           leading: Icon(
          //             Icons.settings,
          //             color: Palette.greenColor,
          //           ),
          //           title: CustomTextStyle(
          //             text: 'Settings',
          //             color: Palette.greenColor,
          //           ),
          //         ),
          //         const ListTile(
          //           leading: Icon(
          //             Icons.phone,
          //             color: Palette.greenColor,
          //           ),
          //           title: CustomTextStyle(
          //             text: 'Phone',
          //             color: Palette.greenColor,
          //           ),
          //         ),
          //         ListTile(
          //           onTap: () async {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) {
          //                   return const CartScreen();
          //                 },
          //               ),
          //             );
          //           },
          //           leading: const Icon(
          //             Icons.shopping_cart,
          //             color: Palette.greenColor,
          //           ),
          //           title: const CustomTextStyle(
          //             text: 'Cart',
          //             color: Palette.greenColor,
          //           ),
          //         ),
          //         ListTile(
          //           onTap: () async {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) {
          //                   return const UserOrderScreen();
          //                 },
          //               ),
          //             );
          //           },
          //           leading: const Icon(
          //             Icons.shop,
          //             color: Palette.greenColor,
          //           ),
          //           title: const CustomTextStyle(
          //             text: 'Orders',
          //             color: Palette.greenColor,
          //           ),
          //         ),
          //         ListTile(
          //           onTap: () async {
          //             await _auth.signOut().whenComplete(() {
          //               Navigator.push(context,
          //                   MaterialPageRoute(builder: (context) {
          //                 return const LoginScreen();
          //               }));
          //             });
          //           },
          //           leading: const Icon(
          //             Icons.logout,
          //             color: Palette.greenColor,
          //           ),
          //           title: const CustomTextStyle(
          //             text: 'Logout',
          //             color: Palette.greenColor,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Palette.greenColor,
          ),
        );
      },
    );
  }
}
