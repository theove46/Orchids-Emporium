// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orchids_emporium/core/routes/routes.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/core/validators/input_validators.dart';
import 'package:orchids_emporium/core/widgets/primary_input_form_field.dart';
import 'package:orchids_emporium/core/widgets/primary_snackbar.dart';
import 'package:orchids_emporium/users/controllers/auth_controller.dart';
import 'package:orchids_emporium/core/theme/palette.dart';

part '../widgets/navigate_to_sign_in.dart';
part '../widgets/sign_up_button_builder.dart';
part '../widgets/sign_up_form_builder.dart';
part '../widgets/image_builder.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Uint8List? _image;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              _backgroundImage(context),
              _signUpFields(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Image.asset(
      'assets/images/plant_auth_bg.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  Widget _signUpFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Sign Up',
            style: AppTypography.bold36(
              color: Palette.whiteColor,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Palette.blackColor.withOpacity(_opacity),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      ImageBuilder(
                        image: _image,
                        onImageChanged: (newImage) {
                          setState(() {
                            _image = newImage;
                          });
                        },
                      ),
                      SizedBox(height: 30.h),
                      _SignUpFormBuilder(
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      SizedBox(height: 20.h),
                      _SignUpButtonBuilder(
                        formKey: _formKey,
                        image: _image,
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                      ),
                      const _SignInNavigationBuilder(),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
