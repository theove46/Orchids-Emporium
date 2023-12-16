// ignore_for_file: use_build_context_synchronously

part of '../pages/phone_number_page.dart';

class _PhoneNumberCard extends StatelessWidget {
  const _PhoneNumberCard({
    required this.phoneController,
    required this.formKey,
    required this.userData,
    required this.totalPrice,
  });

  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;

  final dynamic userData;
  final double totalPrice;

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
          _accountNumberField(),
          const SizedBox(height: 10),
          _subtitleText(),
        ],
      ),
    );
  }

  Widget _cardTitle() {
    return const Text(
      'Your bKash Account number',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _accountNumberField() {
    return InputFormField(
      textEditingController: phoneController,
      style: const TextStyle(
        fontSize: 24,
        color: Palette.grey,
      ),
      hintText: 'e.g 01XXXXXXXXX',
      hintTextStyle: const TextStyle(
        fontSize: 24,
        color: Palette.grey,
      ),
      keyboardType: TextInputType.phone,
      validator: InputValidators.phone,
      textAlign: TextAlign.center,
      maxLength: 11,
    );
  }

  Widget _subtitleText() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: 'By clicking on ',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: 'Confirm',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ', you are agreeing to the ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: 'terms & conditions',
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
                return VerificationCodePage(
                  userData: userData,
                  totalPrice: totalPrice,
                  phoneNumber: phoneController.text,
                );
              },
            ),
          );
        } else {
          ShowSnackBarMessage.showErrorSnackBar(
            message: 'Please enter a valid account number',
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
