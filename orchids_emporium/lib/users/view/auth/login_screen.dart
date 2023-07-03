// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orchids_emporium/users/controllers/auth_controller.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/core/show_snackbar.dart';
import 'package:orchids_emporium/users/view/auth/register_screen.dart';
import 'package:orchids_emporium/users/view/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isLoading = false;
  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.2;

  _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      String res =
          await _authController.loginUsers(email, password).whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });

      if (res == 'success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const MainScreen();
        }));
      } else {
        showSnack(context, res);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Fields must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/plantBg.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                  const CustomTextStyle(
                    text: 'Log in',
                    size: 40,
                    fontWeight: FontWeight.bold,
                    color: Palette.whiteColor,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.blackColor.withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomTextStyle(
                                  text: 'Log in your account',
                                  color: Palette.whiteColor,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email must not be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  obscureText: false,
                                  cursorColor: Palette.greyColor,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    hintText: 'Enter email',
                                    hintStyle: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Palette.greyColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password must not be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  obscureText: true,
                                  cursorColor: Palette.greyColor,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    hintText: 'Enter password',
                                    hintStyle: GoogleFonts.ubuntu(
                                      fontSize: 16,
                                      color: Palette.greyColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                GestureDetector(
                                  onTap: () {
                                    //print('Login clicked');
                                    _loginUser();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const MainScreen()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      color: Palette.greenColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: _isLoading
                                          ? const CircularProgressIndicator(
                                              color: Palette.whiteColor,
                                            )
                                          : const CustomTextStyle(
                                              text: 'Continue',
                                              color: Palette.whiteColor,
                                              size: 26,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CustomTextStyle(
                                        text: 'Do not have an account?',
                                        color: Palette.whiteColor),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BuyersRegisterScreen()));
                                      },
                                      child: const CustomTextStyle(
                                        text: 'Sign up',
                                        size: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.greenColor,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const CustomTextStyle(
                                      text: 'Forgot Password?',
                                      size: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.greenColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
