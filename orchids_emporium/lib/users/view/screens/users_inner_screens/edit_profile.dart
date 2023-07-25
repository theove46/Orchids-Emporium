// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userData});
  final dynamic userData;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();
  String _imageUrl = '';

  _saveVendorDetails() async {
    EasyLoading.show(status: 'Please wait');
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Profile updating');
      await _firestore
          .collection('buyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'profileImage': _imageUrl.toString(),
      }).whenComplete(() {
        EasyLoading.dismiss();
        Navigator.pop(context);
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    setState(() {
      _fullNameController.text = widget.userData['fullName'];
      _emailController.text = widget.userData['email'];
      _phoneController.text = widget.userData['phone'];
      _addressController.text = widget.userData['address'];
      _imageUrl = widget.userData['profileImage'] ?? '';
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
        title: const CustomTextStyle(
          text: 'Edit profile',
          size: 20,
          fontWeight: FontWeight.bold,
          color: Palette.greenColor,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Palette.greenColor,
                      backgroundImage:
                          _imageUrl.isNotEmpty ? NetworkImage(_imageUrl) : null,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _fullNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      color: Palette.greenColor,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Enter full name',
                      enabledBorder: OutlineInputBorder(
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
                      hintStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      color: Palette.greenColor,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter email address',
                      enabledBorder: OutlineInputBorder(
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
                      hintStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      color: Palette.greenColor,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      enabledBorder: OutlineInputBorder(
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
                      hintStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please this field must not be empty';
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      color: Palette.greenColor,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      enabledBorder: OutlineInputBorder(
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
                      hintStyle: GoogleFonts.ubuntu(
                        color: Palette.greenColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _saveVendorDetails();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const CustomTextStyle(
                      text: 'Save',
                      size: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
