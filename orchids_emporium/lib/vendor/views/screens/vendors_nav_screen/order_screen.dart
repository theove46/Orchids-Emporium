// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';

class VendorOrderScreen extends StatelessWidget {
  VendorOrderScreen({super.key});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String formatedDate(date) {
    final outputDateFormate = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormate.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: Palette.secondary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.secondary,
        iconTheme: const IconThemeData(
          color: Palette.primary,
        ),
        title: Text(
          'My Orders',
          style: AppTypography.bold24(),
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
                color: Palette.primary,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              double totalOrder =
                  document['quantity'] * document['productPrice'];
              return Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(document['orderId'])
                            .update({
                          'accepted': true,
                        });
                      },
                      flex: 2,
                      backgroundColor: Palette.primary,
                      foregroundColor: Palette.secondary,
                      icon: Icons.gpp_good_rounded,
                      label: 'Accept',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore
                            .collection('orders')
                            .doc(document['orderId'])
                            .update({
                          'accepted': false,
                        });
                      },
                      flex: 2,
                      backgroundColor: Palette.red,
                      foregroundColor: Palette.secondary,
                      icon: Icons.gpp_bad_rounded,
                      label: 'Reject',
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Palette.secondary,
                        radius: 19,
                        child: document['accepted'] == true
                            ? const Icon(
                                Icons.delivery_dining_outlined,
                                color: Palette.primary,
                              )
                            : const Icon(
                                Icons.access_time_outlined,
                                color: Palette.primary,
                              ),
                      ),
                      title: document['accepted'] == true
                          ? Text(
                              'Accepted',
                              style: AppTypography.bold12(),
                            )
                          : Text(
                              'Not Accepted',
                              style: AppTypography.bold12(
                                color: Palette.red,
                              ),
                            ),
                      subtitle: Text(
                        formatedDate(document['orderDate'].toDate()),
                        style: AppTypography.regular16(),
                      ),
                      trailing: Text(
                        '৳ ${totalOrder.toStringAsFixed(2)}',
                        style: AppTypography.bold16(),
                      ),
                    ),
                    ExpansionTile(
                      collapsedIconColor: Palette.primary,
                      iconColor: Palette.primary,
                      title: Text(
                        'Order Details',
                        style: AppTypography.bold16(),
                      ),
                      children: [
                        ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image:
                                    NetworkImage(document['productImage'][0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            document['productName'],
                            style: AppTypography.bold20(),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quantity: ${document['quantity']}',
                                style: AppTypography.bold16(),
                              ),
                              Text(
                                'Buyer details:',
                                style: AppTypography.bold16(),
                              ),
                              Text(
                                'Name: ${document['buyerName']}',
                                style: AppTypography.bold16(),
                              ),
                              Text(
                                'Address: ${document['buyerAddress']}',
                                style: AppTypography.bold16(),
                              ),
                              Text(
                                'Phone: ${document['buyerPhone']}',
                                style: AppTypography.bold16(),
                              ),
                              Text(
                                'Email: ${document['buyerEmail']}',
                                style: AppTypography.bold16(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Palette.primary,
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
