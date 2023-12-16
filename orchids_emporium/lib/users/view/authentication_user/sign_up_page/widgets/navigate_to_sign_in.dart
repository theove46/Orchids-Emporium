part of '../pages/user_sign_up_page.dart';

class _SignInNavigationBuilder extends StatefulWidget {
  const _SignInNavigationBuilder();

  @override
  State<_SignInNavigationBuilder> createState() =>
      _SignInNavigationBuilderState();
}

class _SignInNavigationBuilderState extends State<_SignInNavigationBuilder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: AppTypography.regular16(
            color: Palette.secondary,
          ),
        ),
        TextButton(
          onPressed: _navigateToSignInPage,
          child: Text(
            'Sign In',
            style: AppTypography.bold18(
              color: Palette.secondary,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToSignInPage() {
    Navigator.pushNamed(
      context,
      Routes.signIn,
    );
  }
}
