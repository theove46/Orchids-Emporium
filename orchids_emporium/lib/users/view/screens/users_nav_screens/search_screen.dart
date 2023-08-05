// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/screens/users_inner_screens/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchedValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _searchedValue = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for products',
                hintStyle: GoogleFonts.ubuntu(
                  fontSize: 16,
                  color: Palette.greenColor,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Palette.greenColor,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Palette.greenColor,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Palette.greenColor,
                  ),
                ),
              ),
              cursorColor: Palette.greenColor,
            ),
            const SizedBox(
              height: 10,
            ),
            _searchedValue == ''
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        const Icon(
                          Icons.search,
                          size: 80,
                          color: Palette.greenColor,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Search for products',
                          style: AppTypography.bold36(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: _productsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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

                      final searchedData = snapshot.data!.docs.where(
                        (element) {
                          return element['productName']
                              .toLowerCase()
                              .contains(_searchedValue.toLowerCase());
                        },
                      );

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) {
                            final productData = searchedData.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return ProductDetailsScreen(
                                      productData: productData,
                                    );
                                  }),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                color: Palette.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                productData['imageUrl'][0]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Text(
                                          productData['productName'],
                                          style: AppTypography.bold24(),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '৳ ${productData['productPrice'].toStringAsFixed(2)}',
                                              style: AppTypography.bold16(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: searchedData.length,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
