// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

class UserOrderScreen extends StatelessWidget {
  const UserOrderScreen({super.key});

  String formatedDate(date) {
    final outputDateFormate = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormate.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.whiteColor,
        iconTheme: const IconThemeData(
          color: Palette.greenColor,
        ),
        title: const CustomTextStyle(
          text: 'My Orders',
          size: 24,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _orderStream,
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

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              double totalOrder =
                  document['quantity'] * document['productPrice'];
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Palette.whiteColor,
                      radius: 19,
                      child: document['accepted'] == true
                          ? const Icon(
                              Icons.delivery_dining_outlined,
                              color: Palette.greenColor,
                            )
                          : const Icon(
                              Icons.access_time_outlined,
                              color: Palette.greenColor,
                            ),
                    ),
                    title: document['accepted'] == true
                        ? const CustomTextStyle(
                            text: 'Accepted',
                            size: 12,
                            fontWeight: FontWeight.bold,
                            color: Palette.greenColor,
                          )
                        : const CustomTextStyle(
                            text: 'Not Accepted',
                            size: 12,
                            fontWeight: FontWeight.bold,
                            color: Palette.redColor,
                          ),
                    subtitle: CustomTextStyle(
                      text: formatedDate(document['orderDate'].toDate()),
                      size: 16,
                      color: Palette.greenColor,
                    ),
                    trailing: CustomTextStyle(
                      text: '৳ ${totalOrder.toStringAsFixed(2)}',
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.greenColor,
                    ),
                  ),
                  ExpansionTile(
                    collapsedIconColor: Palette.greenColor,
                    iconColor: Palette.greenColor,
                    title: const CustomTextStyle(
                      text: 'Order Details',
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Palette.greenColor,
                    ),
                    children: [
                      ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: NetworkImage(document['productImage'][0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: CustomTextStyle(
                          text: document['productName'],
                          size: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.greenColor,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextStyle(
                              text: 'Quantity: ${document['quantity']}',
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Palette.greenColor,
                            ),
                            const CustomTextStyle(
                              text: 'Buyer details:',
                              size: 16,
                              fontWeight: FontWeight.bold,
                              color: Palette.greenColor,
                            ),
                            CustomTextStyle(
                              text: 'Name: ${document['buyerName']}',
                              size: 16,
                              color: Palette.greenColor,
                            ),
                            CustomTextStyle(
                              text: 'Address: ${document['buyerAddress']}',
                              size: 16,
                              color: Palette.greenColor,
                            ),
                            CustomTextStyle(
                              text: 'Phone: ${document['buyerPhone']}',
                              size: 16,
                              color: Palette.greenColor,
                            ),
                            CustomTextStyle(
                              text: 'Email: ${document['buyerEmail']}',
                              size: 16,
                              color: Palette.greenColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Palette.greenColor,
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
