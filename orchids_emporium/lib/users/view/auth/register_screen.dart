// ignore_for_file: use_build_context_synchronously, unused_field
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchids_emporium/users/controllers/auth_controller.dart';
import 'package:orchids_emporium/core/custom_textstyle.dart';
import 'package:orchids_emporium/core/palette.dart';
import 'package:orchids_emporium/core/show_snackbar.dart';
import 'package:orchids_emporium/users/view/auth/login_screen.dart';

class BuyersRegisterScreen extends StatefulWidget {
  const BuyersRegisterScreen({super.key});

  @override
  State<BuyersRegisterScreen> createState() => _BuyersRegisterScreenState();
}

class _BuyersRegisterScreenState extends State<BuyersRegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String fullName;

  late String email;

  late String phone;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUsers(fullName, email, phone, password, _image)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      return showSnack(context, 'Account has been created');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Fields must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List img = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  selectCameraImage() async {
    Uint8List img = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = img;
    });
  }

  final double _sigmaX = 5;

  final double _sigmaY = 5;

  final double _opacity = 0.2;

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const CustomTextStyle(
                    text: 'Sign up',
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Palette.blackColor.withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CustomTextStyle(
                                    text: 'Create a new account',
                                    color: Palette.whiteColor,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  Stack(
                                    children: [
                                      _image != null
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  Palette.greenColor,
                                              backgroundImage:
                                                  MemoryImage(_image!),
                                            )
                                          : const CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  Palette.greenColor,
                                              backgroundImage: AssetImage(
                                                'assets/images/profile icon.png',
                                              ),
                                            ),
                                      Positioned(
                                        right: -10,
                                        top: -10,
                                        child: IconButton(
                                          onPressed: () {
                                            selectGalleryImage();
                                          },
                                          icon: const Icon(
                                              CupertinoIcons.add_circled,
                                              color: Palette.whiteColor),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Full Name must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      fullName = value;
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
                                      hintText: 'Enter full name',
                                      hintStyle: GoogleFonts.ubuntu(
                                        fontSize: 16,
                                        color: Palette.greyColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Phone number must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      phone = value;
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
                                      hintText: 'Enter phone number',
                                      hintStyle: GoogleFonts.ubuntu(
                                        fontSize: 16,
                                        color: Palette.greyColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  GestureDetector(
                                    onTap: () {
                                      //print('SignUp clicked');
                                      _signUpUser();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             LoginScreen()));
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
                                                size: 26,
                                                color: Palette.whiteColor,
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomTextStyle(
                                          text: 'Already have an account?',
                                          color: Palette.whiteColor),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                        },
                                        child: const CustomTextStyle(
                                          text: 'Log in',
                                          size: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.greenColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
