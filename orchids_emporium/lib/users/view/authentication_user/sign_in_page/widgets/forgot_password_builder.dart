part of '../pages/user_sign_in_page.dart';

class _ForgotPasswordBuilder extends StatelessWidget {
  const _ForgotPasswordBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Forgot Password?',
        style: AppTypography.bold16(
          color: Palette.secondary,
        ),
      ),
    );
  }
}
