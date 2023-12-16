// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/users/view/users_inner_screens/product_details_screen.dart';

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _searchField(),
            const SizedBox(height: 10),
            _searchedValue == ''
                ? _emptyList()
                : _searchedList(_productsStream),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _searchedValue = value;
        });
      },
      style: AppTypography.regular16(),
      decoration: InputDecoration(
        hintText: 'Search for products',
        hintStyle: AppTypography.regular16(),
        prefixIcon: const Icon(
          Icons.search,
          color: Palette.primary,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Palette.primary,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Palette.primary,
          ),
        ),
      ),
      cursorColor: Palette.primary,
    );
  }

  Widget _searchedList(Stream<QuerySnapshot<Object?>> _productsStream) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
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

        final searchedData = snapshot.data!.docs.where(
          (element) {
            return element['productName']
                .toLowerCase()
                .contains(_searchedValue.toLowerCase());
          },
        );

        return SizedBox(
          height: 750.h,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  color: Palette.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              image: NetworkImage(productData['imageUrl'][0]),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }

  Widget _emptyList() {
    return SizedBox(
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 80,
            color: Palette.primary,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Search for products',
            style: AppTypography.bold36(),
          ),
        ],
      ),
    );
  }
}
