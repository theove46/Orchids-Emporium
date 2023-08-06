// ignore_for_file: use_build_context_synchronously, must_be_immutable

part of '../pages/user_sign_up_page.dart';

class _SignUpButtonBuilder extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Uint8List? image;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _SignUpButtonBuilder({
    required this.formKey,
    required this.image,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<_SignUpButtonBuilder> createState() => _SignUpButtonBuilderState();
}

class _SignUpButtonBuilderState extends State<_SignUpButtonBuilder> {
  final UserAuthController _userAuthController = UserAuthController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _signUpUser();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Palette.whiteColor,
                )
              : Text(
                  'Continue',
                  style: AppTypography.regular24(
                    color: Palette.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.formKey.currentState!.validate() && widget.image != null) {
      try {
        await _userAuthController.signUpUsers(
          widget.fullNameController.text,
          widget.emailController.text,
          widget.phoneController.text,
          widget.passwordController.text,
          widget.image,
        );

        setState(() {
          _isLoading = false;
        });

        ShowSnackBarMessage.showSuccessSnackBar(
          message: 'Account has been created',
          context: context,
        );

        _navigateToSignInPage();
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        ShowSnackBarMessage.showErrorSnackBar(
          message: 'An error occurred. Please try again.',
          context: context,
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      ShowSnackBarMessage.showErrorSnackBar(
        message: 'Fields and Image must not be empty',
        context: context,
      );
    }
  }

  void _navigateToSignInPage() {
    Navigator.pushNamed(
      context,
      Routes.signIn,
    );
  }
}
