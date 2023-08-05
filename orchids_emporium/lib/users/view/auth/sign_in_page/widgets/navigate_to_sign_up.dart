part of '../pages/user_sign_in_page.dart';

class _SignUpNavigationBuilder extends StatefulWidget {
  const _SignUpNavigationBuilder();

  @override
  State<_SignUpNavigationBuilder> createState() =>
      _SignUpNavigationBuilderState();
}

class _SignUpNavigationBuilderState extends State<_SignUpNavigationBuilder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do not have an account?',
          style: AppTypography.regular16(
            color: Palette.whiteColor,
          ),
        ),
        TextButton(
          onPressed: _navigateToSignUpPage,
          child: Text(
            'Sign Up',
            style: AppTypography.bold18(
              color: Palette.whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToSignUpPage() {
    Navigator.pushNamed(
      context,
      Routes.signUp,
    );
  }
}
