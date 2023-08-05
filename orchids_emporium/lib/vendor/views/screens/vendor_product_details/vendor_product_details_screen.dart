import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/core/widgets/show_snackbar.dart';

class VendorProductDetailsScreen extends StatefulWidget {
  final dynamic productData;
  const VendorProductDetailsScreen({super.key, this.productData});

  @override
  State<VendorProductDetailsScreen> createState() =>
      _VendorProductDetailsScreenState();
}

class _VendorProductDetailsScreenState
    extends State<VendorProductDetailsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final List<String> _catagoryList = [];
  double? productPrice;
  int? quantity;
  String? category;

  _getCatagories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _catagoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCatagories();
    setState(() {
      productPrice = widget.productData['productPrice'];
      quantity = widget.productData['quantity'];
      category = widget.productData['category'];
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _quantityController.text = widget.productData['quantity'].toString();
      _productPriceController.text =
          widget.productData['productPrice'].toString();
      _descriptionController.text = widget.productData['description'];
      _categoryController.text = widget.productData['category'];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.whiteColor,
        iconTheme: const IconThemeData(
          color: Palette.greenColor,
        ),
        title: Text(
          widget.productData['productName'],
          style: AppTypography.bold20(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _productNameController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Enter product name';
                  } else {
                    return null;
                  }
                }),
                cursorColor: Palette.greenColor,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  fillColor: Palette.whiteColor,
                  filled: true,
                  labelText: ' Product name ',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Palette.greyColor,
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _brandNameController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Enter brand name';
                  } else {
                    return null;
                  }
                }),
                cursorColor: Palette.greenColor,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  fillColor: Palette.whiteColor,
                  filled: true,
                  labelText: 'Brand name',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Palette.greyColor,
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                controller: _quantityController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Enter quantity';
                  } else {
                    return null;
                  }
                }),
                cursorColor: Palette.greenColor,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  fillColor: Palette.whiteColor,
                  filled: true,
                  labelText: 'Quantity',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Palette.greyColor,
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                onChanged: (value) {
                  productPrice = double.parse(value);
                },
                controller: _productPriceController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Enter price';
                  } else {
                    return null;
                  }
                }),
                cursorColor: Palette.greenColor,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  fillColor: Palette.whiteColor,
                  filled: true,
                  labelText: 'Price',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Palette.greyColor,
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Enter description';
                  } else {
                    return null;
                  }
                }),
                maxLength: 800,
                maxLines: 3,
                cursorColor: Palette.greenColor,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  fillColor: Palette.whiteColor,
                  filled: true,
                  labelText: 'Description',
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Palette.greyColor,
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                value: category,
                onChanged: (value) {
                  category = value;
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.greenColor),
                  ),
                  fillColor: Palette.whiteColor,
                  filled: true,
                  labelText: 'Category',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                  floatingLabelStyle: GoogleFonts.ubuntu(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.greenColor,
                  ),
                ),
                items: _catagoryList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Material(
        color: Palette.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                EasyLoading.show(status: 'Updating product');
                await _firestore
                    .collection('products')
                    .doc(widget.productData['productId'])
                    .update({
                  'productName': _productNameController.text,
                  'brandName': _brandNameController.text,
                  'quantity': quantity,
                  'productPrice': productPrice,
                  'description': _descriptionController.text,
                  'category': category,
                }).whenComplete(() {
                  EasyLoading.dismiss();
                  showSnack(context, 'Product update successfully');
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Palette.greenColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                'Update product',
                style: AppTypography.regular16(
                  color: Palette.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
