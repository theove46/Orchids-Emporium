// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/core/custom_circuler_progress.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? name;
  String? phone;
  String? bankName;
  String? accountName;
  String? accountNumber;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      _amountController.text = '';
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
          'Withdraw',
          style: AppTypography.bold20(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _amountController,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please enter withdrawal amount';
                    } else {
                      return null;
                    }
                  }),
                  keyboardType: TextInputType.number,
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
                    hintText: 'Withdrawal Amount',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    } else {
                      return null;
                    }
                  }),
                  onChanged: (value) {
                    name = value;
                  },
                  keyboardType: TextInputType.name,
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
                    hintText: 'Vendors Name',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    } else {
                      return null;
                    }
                  }),
                  onChanged: (value) {
                    phone = value;
                  },
                  keyboardType: TextInputType.number,
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
                    hintText: 'Phone Number',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please enter bank name';
                    } else {
                      return null;
                    }
                  }),
                  onChanged: (value) {
                    bankName = value;
                  },
                  keyboardType: TextInputType.name,
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
                    hintText: 'Bank Name',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please enter your account name';
                    } else {
                      return null;
                    }
                  }),
                  onChanged: (value) {
                    accountName = value;
                  },
                  keyboardType: TextInputType.name,
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
                    hintText: 'Account Name',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Please enter account number';
                    } else {
                      return null;
                    }
                  }),
                  onChanged: (value) {
                    accountNumber = value;
                  },
                  keyboardType: TextInputType.number,
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
                    hintText: 'Account Number',
                    hintStyle: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Palette.greyColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _showConfirmationDialog(context);
                      }
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
                      'Withdraw cash',
                      style: AppTypography.regular16(
                        color: Palette.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20.0),
          backgroundColor: Palette.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Vendors Name: \n${name.toString()}',
                      style: AppTypography.regular20(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Phone Number: \n${phone.toString()}',
                      style: AppTypography.regular20(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Bank Name: \n${bankName.toString()}',
                      style: AppTypography.regular20(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Account Name: \n${accountName.toString()}',
                      style: AppTypography.regular20(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Account Number: \n${accountNumber.toString()}',
                      style: AppTypography.regular20(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Withdrawal Amount: \n৳ ${double.parse(_amountController.text).toStringAsFixed(2)}',
                      style: AppTypography.regular20(),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                CustomProgress(),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
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
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _saveWithdrawalDetails();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWithdrawalDetails() async {
    EasyLoading.show(status: 'Withdrawing amount');
    await _firestore.collection('withdrawal').doc(const Uuid().v4()).set(
      {
        'amount': double.parse(_amountController.text),
        'name': name,
        'phone': phone,
        'bankName': bankName,
        'accountName': accountName,
        'accountNumber': accountNumber,
      },
    ).whenComplete(
      () {
        _formKey.currentState!.reset();
        EasyLoading.dismiss();
        Navigator.pop(context);
      },
    );
  }
}
