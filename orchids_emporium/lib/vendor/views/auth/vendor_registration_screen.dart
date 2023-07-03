// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_final_fields

import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/vendor/controllers/vendor_register_controller.dart';

class VendorRegistrationScreen extends StatefulWidget {
  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();

  late String companyName;
  late String email;
  late String phone;
  late String taxNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List img = await _vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  selectCameraImage() async {
    Uint8List img = await _vendorController.pickStoreImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  String? _taxStatus;

  List<String> _taxOptions = [
    'Yes',
    'No',
  ];

  _saveVendorDetails() async {
    EasyLoading.show(status: 'Please wait');
    if (_formKey.currentState!.validate()) {
      await _vendorController
          .registerVendor(companyName, email, phone, countryValue, stateValue,
              cityValue, _taxStatus!, taxNumber, _image)
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      });
    } else {
      //print('Bad');
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 200,
          flexibleSpace: LayoutBuilder(builder: (context, contrainsts) {
            return FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: Palette.greenColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Palette.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  selectGalleryImage();
                                },
                                icon: const Icon(Icons.add_a_photo),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      companyName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Company name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.greenColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.greenColor,
                        ),
                      ),
                      labelStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.greenColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.greenColor,
                        ),
                      ),
                      labelStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      phone = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.greenColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.greenColor,
                        ),
                      ),
                      labelStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                        style: GoogleFonts.ubuntu(
                          color: Palette.greenColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomTextStyle(
                            text: 'TAX registered?',
                            color: Palette.greenColor,
                          ),
                          SizedBox(
                            width: 100,
                            child: Flexible(
                              child: DropdownButtonFormField(
                                  hint: const CustomTextStyle(
                                    text: 'Select',
                                    color: Palette.greenColor,
                                  ),
                                  items: _taxOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: CustomTextStyle(
                                          text: value,
                                          color: Palette.greenColor,
                                        ));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _taxStatus = value;
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_taxStatus == 'Yes')
                    TextFormField(
                      onChanged: (value) {
                        taxNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please this field must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tax number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Palette.greenColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Palette.greenColor,
                          ),
                        ),
                        labelStyle: GoogleFonts.ubuntu(
                          color: Palette.greenColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _saveVendorDetails();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Palette.greenColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: CustomTextStyle(
                          text: 'Save',
                          fontWeight: FontWeight.bold,
                          color: Palette.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
