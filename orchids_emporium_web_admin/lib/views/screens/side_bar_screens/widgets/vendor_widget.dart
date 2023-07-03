import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';

class VendorWidget extends StatelessWidget {
  const VendorWidget({Key? key}) : super(key: key);

  Widget VendorData(int? flex, Widget widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final vendorUserData = snapshot.data!.docs[index];
              return Container(
                child: Row(
                  children: [
                    VendorData(
                      1,
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.network(vendorUserData['storeImage']),
                      ),
                    ),
                    VendorData(
                      3,
                      CustomTextStyle(
                        text: vendorUserData['companyName'],
                        size: 16,
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    VendorData(
                      2,
                      CustomTextStyle(
                        text: vendorUserData['cityValue'],
                        size: 16,
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    VendorData(
                      2,
                      CustomTextStyle(
                        text: vendorUserData['stateValue'],
                        size: 16,
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    VendorData(
                      1,
                      vendorUserData['approved'] == false
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Palette.redColor,
                              ),
                              onPressed: () async {
                                await _firestore
                                    .collection('vendors')
                                    .doc(vendorUserData['vendorId'])
                                    .update({
                                  'approved': true,
                                });
                              },
                              child: CustomTextStyle(
                                text: 'Rejected',
                                size: 16,
                                color: Palette.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Palette.greenColor,
                              ),
                              onPressed: () async {
                                await _firestore
                                    .collection('vendors')
                                    .doc(vendorUserData['vendorId'])
                                    .update({
                                  'approved': false,
                                });
                              },
                              child: CustomTextStyle(
                                text: 'Approved',
                                size: 16,
                                color: Palette.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    VendorData(
                      1,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.greenColor,
                        ),
                        onPressed: () {},
                        child: CustomTextStyle(
                          text: 'Details',
                          size: 16,
                          color: Palette.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
