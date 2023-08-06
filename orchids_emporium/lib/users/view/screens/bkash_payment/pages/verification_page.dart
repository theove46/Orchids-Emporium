// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:orchids_emporium/users/view/screens/bkash_payment/pages/pin_number_page.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/validators/input_validators.dart';
import 'package:orchids_emporium/core/widgets/primary_input_form_field.dart';
import 'package:orchids_emporium/core/widgets/primary_snackbar.dart';

part '../widgets/verification_code_card.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({
    super.key,
    required this.phoneNumber,
    required this.userData,
    required this.totalPrice,
  });

  final String phoneNumber;
  final dynamic userData;
  final double totalPrice;

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.pinkColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
          title: const Text(
            'bKash Checkout',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _bkashLogo(),
                  const SizedBox(height: 10),
                  _divider(),
                  _userInfo(),
                  _VerificationCodeCard(
                    verificationCodeController: _verificationCodeController,
                    formKey: _formKey,
                    userData: widget.userData,
                    totalPrice: widget.totalPrice,
                    phoneNumber: widget.phoneNumber,
                  ),
                  const SizedBox(height: 10),
                  _helpLineNumber()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bkashLogo() {
    return Center(
      child: Image.asset(
        'assets/images/bkash_payment_logo.png',
        width: 300,
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: Palette.pinkColor,
      thickness: 6,
    );
  }

  Widget _userInfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.userData['profileImage']),
      ),
      title: Text(
        widget.userData['fullName'],
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        widget.userData['fullName'].length > 10
            ? widget.userData['buyerId'].substring(0, 14)
            : widget.userData['buyerId'],
      ),
      trailing: Text(
        '৳ ${widget.totalPrice.toStringAsFixed(2)}',
        // style: TextStyle(
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _helpLineNumber() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Palette.pinkColor,
          child: Icon(
            Icons.phone,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Text(
          '16247',
          style: TextStyle(
            fontSize: 30,
            color: Palette.pinkColor,
          ),
        ),
      ],
    );
  }
}
