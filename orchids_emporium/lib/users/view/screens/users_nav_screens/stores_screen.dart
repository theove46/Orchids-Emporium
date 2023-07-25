// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/store_details_screen.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return Scaffold(
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.whiteColor,
        iconTheme: const IconThemeData(
          color: Palette.greenColor,
        ),
        title: const CustomTextStyle(
          text: 'Stores',
          size: 24,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _vendorsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.greenColor,
              ),
            );
          }

          return SizedBox(
            height: double.infinity,
            child: ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                final storeData = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StoreDetailsScreen(
                              storeData: storeData,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      color: Palette.whiteColor,
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(storeData['storeImage']),
                        ),
                        title: CustomTextStyle(
                          text: storeData['companyName'],
                          color: Palette.greenColor,
                          size: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle: CustomTextStyle(
                          text:
                              '${storeData['countryValue']}, ${storeData['cityValue']} ',
                          color: Palette.greenColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: 60,
        width: double.infinity,
        color: Palette.greenColor,
      ),
    );
  }
}
