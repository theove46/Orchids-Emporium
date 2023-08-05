import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/auth/sign_in_page/pages/user_sign_in_page.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/edit_profile.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/user_order_screen.dart';
import 'package:orchids_emporium/users/view/screens/users_nav_screens/cart_screen.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
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
          return Scaffold(
            backgroundColor: Palette.whiteColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Palette.whiteColor,
              iconTheme: const IconThemeData(
                color: Palette.greenColor,
              ),
              title: Text(
                'My Profile',
                style: AppTypography.bold20(),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Palette.greenColor,
                      backgroundImage: NetworkImage(data['profileImage']),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['fullName'],
                    style: AppTypography.bold24(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data['email'],
                    style: AppTypography.regular20(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditProfileScreen(
                                userData: data,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.greenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Edit profile',
                        style: AppTypography.bold24(
                          color: Palette.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Palette.greenColor,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Palette.greenColor,
                    ),
                    title: Text(
                      'Settings',
                      style: AppTypography.regular16(),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Palette.greenColor,
                    ),
                    title: Text(
                      'Phone',
                      style: AppTypography.regular16(),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CartScreen();
                          },
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Palette.greenColor,
                    ),
                    title: Text(
                      'Cart',
                      style: AppTypography.regular16(),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const UserOrderScreen();
                          },
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.shop,
                      color: Palette.greenColor,
                    ),
                    title: Text(
                      'Orders',
                      style: AppTypography.regular16(),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await _auth.signOut().whenComplete(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const UserSignInPage();
                        }));
                      });
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Palette.greenColor,
                    ),
                    title: Text(
                      'Logout',
                      style: AppTypography.regular16(),
                    ),
                  ),
                ],
              ),
            ),
          );
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
