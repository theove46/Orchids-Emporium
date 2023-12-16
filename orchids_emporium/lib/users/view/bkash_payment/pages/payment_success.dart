// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/users/view/user_dashboard/user_dashboard_page.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({
    super.key,
    required this.userData,
    required this.totalPrice,
  });

  final dynamic userData;
  final double totalPrice;

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  bool isPaymentConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.pink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const UserDashBoardPage();
                },
              ),
            ); // This pops the current screen and goes back
          },
        ),
        title: const Text(
          'bKash Checkout',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pageTitle(),
          const SizedBox(height: 10),
          _userInfo(),
          const SizedBox(height: 10),
          _paymentAmount(),
          const SizedBox(height: 40),
          _backButton(context),
        ],
      ),
    );
  }

  Widget _pageTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'Payment ',
        style: TextStyle(
          fontSize: 28,
          color: Palette.pink,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'Successful',
            style: TextStyle(
              fontSize: 28,
              color: Palette.pink,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            widget.userData['profileImage'],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          widget.userData['fullName'],
          style: const TextStyle(
            fontSize: 20,
            color: Palette.pink,
          ),
        ),
      ],
    );
  }

  Widget _paymentAmount() {
    return Text(
      'Total Payment: ৳ ${widget.totalPrice.toStringAsFixed(2)}',
      style: const TextStyle(
        fontSize: 20,
        color: Palette.pink,
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const UserDashBoardPage();
              },
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.pink,
        ),
        child: const Text('Back to Home'),
      ),
    );
  }
}
