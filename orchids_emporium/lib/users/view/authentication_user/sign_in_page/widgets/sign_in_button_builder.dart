// ignore_for_file: use_build_context_synchronously

part of '../pages/user_sign_in_page.dart';

class _SignInButtonBuilder extends StatefulWidget {
  const _SignInButtonBuilder({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<_SignInButtonBuilder> createState() => _SignInButtonBuilderState();
}

class _SignInButtonBuilderState extends State<_SignInButtonBuilder> {
  final UserAuthController _userAuthController = UserAuthController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        buttonTitle: _isLoading
            ? const CircularProgressIndicator(
                color: Palette.secondary,
              )
            : Text(
                'Sign In',
                style: AppTypography.regular24(
                  color: Palette.secondary,
                ),
              ),
        buttonFunction: () {
          _signInUser();
        },
        textColor: Palette.secondary,
        backgroundColor: Palette.primary,
      ),
    );
  }

  _signInUser() async {
    setState(() {
      _isLoading = true;
    });

    if (widget.formKey.currentState!.validate()) {
      try {
        String res = await _userAuthController.loginUsers(
          widget.emailController.text,
          widget.passwordController.text,
        );

        setState(() {
          _isLoading = false;
        });

        if (res == 'success') {
          _navigateToHomePage();
        } else {
          ShowSnackBarMessage.showSuccessSnackBar(
            message: res,
            context: context,
          );
        }
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
        message: 'Fields must not be empty',
        context: context,
      );
    }
  }

  void _navigateToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.userDashBoard,
      (route) => false,
    );
  }
}
