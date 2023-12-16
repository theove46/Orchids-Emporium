// ignore_for_file: use_build_context_synchronously

part of '../pages/verification_page.dart';

class _VerificationCodeCard extends StatelessWidget {
  const _VerificationCodeCard({
    required this.verificationCodeController,
    required this.formKey,
    required this.userData,
    required this.totalPrice,
    required this.phoneNumber,
  });

  final TextEditingController verificationCodeController;
  final GlobalKey<FormState> formKey;

  final dynamic userData;
  final double totalPrice;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.pink,
      elevation: 0,
      child: Column(
        children: [
          _inputField(),
          _buttons(context),
        ],
      ),
    );
  }

  Widget _inputField() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _cardTitle(),
          const SizedBox(height: 10),
          _verificationNumberField(),
          const SizedBox(height: 10),
          _subtitleText(),
        ],
      ),
    );
  }

  Widget _cardTitle() {
    return Text(
      'Enter verification code sent to ${phoneNumber.substring(0, 3)} ** *** ${phoneNumber.substring(8, 11)}',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _verificationNumberField() {
    return InputFormField(
      textEditingController: verificationCodeController,
      style: const TextStyle(
        fontSize: 24,
        color: Palette.grey,
      ),
      hintText: '     bKash Verification Code',
      hintTextStyle: const TextStyle(
        fontSize: 24,
        color: Palette.grey,
      ),
      autocorrect: false,
      keyboardType: TextInputType.number,
      validator: InputValidators.otp,
      textAlign: TextAlign.center,
      maxLength: 6,
      obscureText: true,
    );
  }

  Widget _subtitleText() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: "Didn't receive code? ",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: 'Resend code',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.wavy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      color: Palette.greenWhite.withOpacity(0.9),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _closeButton(context),
          _continueButton(context),
        ],
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(
          context,
        );
      },
      child: const Text(
        'CLOSE',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          EasyLoading.show(status: 'Loading...');
          await Future.delayed(
            const Duration(seconds: 2),
          );
          EasyLoading.dismiss();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PinNumberPageCard(
                  userData: userData,
                  totalPrice: totalPrice,
                  phoneNumber: phoneNumber,
                );
              },
            ),
          );
        } else {
          ShowSnackBarMessage.showErrorSnackBar(
            message: 'Please enter valid verification code',
            context: context,
          );
        }
      },
      child: const Text(
        'CONTINUE',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
