// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/core/validators/input_validators.dart';
import 'package:orchids_emporium/core/widgets/primary_input_form_field.dart';
import 'package:orchids_emporium/core/widgets/primary_snackbar.dart';
import 'package:orchids_emporium/vendor/controllers/vendor_register_controller.dart';
import 'package:orchids_emporium/vendor/views/authentication_vendors/pages/vendor_auth_page.dart';

part '../widgets/vendor_information_entry_form_builder.dart';

class VendorInformationEntryPage extends StatefulWidget {
  const VendorInformationEntryPage({super.key});

  @override
  State<VendorInformationEntryPage> createState() =>
      _VendorInformationEntryPageState();
}

class _VendorInformationEntryPageState
    extends State<VendorInformationEntryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorController _vendorController = VendorController();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _taxNumberController = TextEditingController();
  String? _taxStatus;
  Uint8List? _image;

  final List<String> _taxOptions = [
    'Yes',
    'No',
  ];

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

  _saveVendorDetails() async {
    if (_formKey.currentState!.validate() &&
        _image != null &&
        _taxNumberController.text != null) {
      EasyLoading.show(
        status: 'Please wait',
      );
      await _vendorController
          .registerVendor(
        _companyNameController.text,
        _emailController.text,
        _phoneController.text,
        _taxStatus!,
        _taxNumberController.text,
        _image,
      )
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const VendorAuthPage(),
          ),
          (route) => false,
        );
      });
    } else if (_taxNumberController == null) {
      ShowSnackBarMessage.showErrorSnackBar(
        message: 'Please enter Tax number',
        context: context,
      );
    } else {
      ShowSnackBarMessage.showErrorSnackBar(
        message: 'Please enter the fields',
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                color: Palette.primary,
              ),
              child: Center(
                child: _addImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _VendorInformationFormBuilder(
                      companyNameController: _companyNameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                    ),
                    _isTaxRegistered(),
                    const SizedBox(height: 10),
                    if (_taxStatus == 'Yes')
                      InputFormField(
                        fillColor: Palette.secondary,
                        borderColor: Palette.grey,
                        textEditingController: _taxNumberController,
                        style: AppTypography.regular18(),
                        hintTextStyle: AppTypography.regular18(),
                        hintText: 'Tax identification number',
                        keyboardType: TextInputType.number,
                        validator: InputValidators.name,
                        autocorrect: false,
                      ),
                    const SizedBox(height: 10),
                    _saveButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _addImage() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: Palette.secondary,
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
    );
  }

  Widget _isTaxRegistered() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Palette.grey,
        ),
        color: Palette.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TAX registered?',
              style: AppTypography.regular16(),
            ),
            SizedBox(
              width: 150,
              child: Flexible(
                child: DropdownButtonFormField(
                  iconEnabledColor: Palette.primary,
                  iconDisabledColor: Palette.primary,
                  dropdownColor: Palette.secondary,
                  hint: Text(
                    'Select',
                    style: AppTypography.regular16(),
                  ),
                  items: _taxOptions.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTypography.regular16(),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _taxStatus = value;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _saveButton() {
    return InkWell(
      onTap: () {
        _saveVendorDetails();
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Save',
            style: AppTypography.bold18(
              color: Palette.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
