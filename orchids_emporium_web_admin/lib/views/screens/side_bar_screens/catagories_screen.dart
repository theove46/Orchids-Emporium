// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium_web_admin/core/custom_textstyle.dart';
import 'package:orchids_emporium_web_admin/core/palette.dart';
import 'package:orchids_emporium_web_admin/views/screens/side_bar_screens/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _image;
  String? fileName;
  late String categoryName;

  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  _uploadCategoryBannerToStorage(dynamic imgage) async {
    Reference ref = _storage.ref().child('CategoryImages').child(fileName!);
    UploadTask uploadTask = ref.putData(imgage);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadCatagory() async {
    EasyLoading.show(status: 'uploading...');
    if (_formKey.currentState!.validate() && _image != null) {
      String imageUrl = await _uploadCategoryBannerToStorage(_image);

      await _firestore.collection('categories').doc(fileName).set({
        'image': imageUrl,
        'categoryName': categoryName,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
          fileName = null;
          _formKey.currentState!.reset();
          //clearText();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CustomTextStyle(
                  text: 'Upload Category',
                  size: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
              ),
              Divider(
                color: Palette.greenColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      height: 140,
                      width: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Palette.whiteColor,
                        border: Border.all(
                          color: Palette.greenColor,
                          width: 2,
                        ),
                      ),
                      child: _image != null
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Center(
                              child: CustomTextStyle(
                                text: 'Upload a category image',
                                size: 14,
                                color: Palette.greenColor,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Palette.whiteColor,
                      border: Border.all(
                        color: Palette.whiteColor,
                        width: 2,
                      ),
                    ),
                    child: fileName != null
                        ? CustomTextStyle(
                            text: '${fileName}',
                            size: 10,
                            color: Palette.greenColor,
                          )
                        : Center(
                            child: CustomTextStyle(
                            text: '',
                            size: 10,
                            color: Palette.greenColor,
                          )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: fieldText,
                          onChanged: (value) {
                            categoryName = value;
                          },
                          style: GoogleFonts.ubuntu(
                            fontSize: 14,
                            color: Palette.greenColor,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Category name';
                            } else {
                              return null;
                            }
                          },
                          cursorColor: Palette.greenColor,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.ubuntu(
                              fontSize: 14,
                              color: Palette.greenColor,
                            ),
                            hintText: 'Enter Category Name',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.greenColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.greenColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_image != null && categoryName != null) {
                        uploadCatagory();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.greenColor,
                    ),
                    child: CustomTextStyle(
                      text: 'Save Category',
                      size: 14,
                      color: Palette.whiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Palette.greenColor,
              ),
              Container(
                child: CustomTextStyle(
                  text: 'Categories',
                  size: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.greenColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CatagoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
