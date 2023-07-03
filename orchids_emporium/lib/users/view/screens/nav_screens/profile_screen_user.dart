import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/auth/login_screen.dart';
import 'package:orchids_emporium/users/view/screens/inner_screens/edit_profile.dart';

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
              title: const CustomTextStyle(
                text: 'Profile',
                size: 20,
                fontWeight: FontWeight.bold,
                color: Palette.greenColor,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.nightlight_outlined),
                  onPressed: () {},
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                  CustomTextStyle(
                    text: data['fullName'],
                    color: Palette.greenColor,
                    fontWeight: FontWeight.bold,
                    size: 24,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextStyle(
                    text: data['email'],
                    color: Palette.greenColor,
                    // fontWeight: FontWeight.bold,
                    size: 20,
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
                      child: const CustomTextStyle(
                        text: 'Edit profile',
                        size: 24,
                        fontWeight: FontWeight.bold,
                        color: Palette.whiteColor,
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
                  const ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Palette.greenColor,
                    ),
                    title: CustomTextStyle(
                      text: 'Settings',
                      color: Palette.greenColor,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Palette.greenColor,
                    ),
                    title: CustomTextStyle(
                      text: 'Phone',
                      color: Palette.greenColor,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Palette.greenColor,
                    ),
                    title: CustomTextStyle(
                      text: 'Cart',
                      color: Palette.greenColor,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.shop,
                      color: Palette.greenColor,
                    ),
                    title: CustomTextStyle(
                      text: 'Orders',
                      color: Palette.greenColor,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await _auth.signOut().whenComplete(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      });
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: Palette.greenColor,
                    ),
                    title: const CustomTextStyle(
                      text: 'Logout',
                      color: Palette.greenColor,
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
