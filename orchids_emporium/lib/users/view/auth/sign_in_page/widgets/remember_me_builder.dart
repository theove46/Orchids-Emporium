part of '../pages/user_sign_in_page.dart';

class _RememberMeBuilder extends StatefulWidget {
  const _RememberMeBuilder({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_RememberMeBuilder> createState() => _RememberMeBuilderState();
}

class _RememberMeBuilderState extends State<_RememberMeBuilder> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: SizedBox(
            height: 24.h,
            width: 24.h,
            child: Checkbox(
              value: _rememberMe,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Palette.whiteColor,
              checkColor: Palette.greenColor,
              fillColor: MaterialStateProperty.all(
                Palette.whiteColor,
              ),
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
          ),
        ),
        Text(
          'Remember me',
          style: AppTypography.bold16(
            color: Palette.whiteColor,
          ),
        ),
      ],
    );
  }
}
