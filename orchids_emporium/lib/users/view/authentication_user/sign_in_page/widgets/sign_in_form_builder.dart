part of '../pages/user_sign_in_page.dart';

class _SignInFormBuilder extends StatelessWidget {
  const _SignInFormBuilder({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputFormField(
          textEditingController: emailController,
          labelText: 'Enter email',
          keyboardType: TextInputType.emailAddress,
          validator: InputValidators.email,
          autocorrect: false,
        ),
        InputFormField(
          textEditingController: passwordController,
          bottomMargin: 0,
          labelText: 'Enter password',
          keyboardType: TextInputType.visiblePassword,
          password: EnabledPassword(),
          validator: InputValidators.password,
          autocorrect: false,
        ),
      ],
    );
  }
}
