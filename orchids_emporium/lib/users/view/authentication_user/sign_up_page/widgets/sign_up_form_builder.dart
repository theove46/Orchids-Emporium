part of '../pages/user_sign_up_page.dart';

class _SignUpFormBuilder extends StatelessWidget {
  const _SignUpFormBuilder({
    Key? key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputFormField(
          textEditingController: fullNameController,
          labelText: 'Full name',
          autocorrect: false,
          keyboardType: TextInputType.name,
          validator: InputValidators.name,
        ),
        InputFormField(
          textEditingController: emailController,
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: InputValidators.email,
          autocorrect: false,
        ),
        InputFormField(
          textEditingController: phoneController,
          labelText: 'Phone number',
          autocorrect: false,
          keyboardType: TextInputType.phone,
          validator: InputValidators.phone,
        ),
        InputFormField(
          textEditingController: passwordController,
          labelText: 'Password',
          keyboardType: TextInputType.visiblePassword,
          password: EnabledPassword(),
          validator: InputValidators.password,
        ),
        InputFormField(
          textEditingController: confirmPasswordController,
          bottomMargin: 0.0,
          labelText: 'Confirm password',
          keyboardType: TextInputType.visiblePassword,
          password: EnabledPassword(),
          validator: (value) => InputValidators.confirmPassword(
            value,
            passwordController.text,
          ),
        ),
      ],
    );
  }
}
