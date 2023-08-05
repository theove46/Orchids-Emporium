import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orchids_emporium/core/routes/routes.dart';
import 'package:orchids_emporium/core/typography/style.dart';
import 'package:orchids_emporium/core/validators/input_validators.dart';
import 'package:orchids_emporium/core/widgets/primary_button.dart';
import 'package:orchids_emporium/core/widgets/primary_input_form_field.dart';
import 'package:orchids_emporium/users/controllers/auth_controller.dart';
import 'package:orchids_emporium/core/theme/palette.dart';
import 'package:orchids_emporium/core/widgets/show_snackbar.dart';

part '../widgets/sign_in_form_builder.dart';
part '../widgets/sign_in_button_builder.dart';
part '../widgets/navigate_to_sign_up.dart';
part '../widgets/forgot_password_builder.dart';
part '../widgets/remember_me_builder.dart';

class UserSignInPage extends StatefulWidget {
  const UserSignInPage({super.key});

  @override
  State<UserSignInPage> createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {
  final double _sigmaX = 5;
  final double _sigmaY = 5;
  final double _opacity = 0.2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              _signInFields(context),
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

  Widget _signInFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Sign In',
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
                      _SignInFormBuilder(
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _RememberMeBuilder(
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          const _ForgotPasswordBuilder(),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _SignInButtonBuilder(
                        formKey: _formKey,
                        emailController: _emailController,
                        passwordController: _passwordController,
                      ),
                      SizedBox(height: 10.h),
                      const _SignUpNavigationBuilder(),
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
