part of '../pages/vendor_information_entry_page.dart';

class _VendorInformationFormBuilder extends StatelessWidget {
  const _VendorInformationFormBuilder({
    Key? key,
    required this.companyNameController,
    required this.emailController,
    required this.phoneController,
    // required this.taxNumberController,
  }) : super(key: key);

  final TextEditingController companyNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  // final TextEditingController taxNumberController;

  //String? _taxStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputFormField(
          fillColor: Palette.secondary,
          borderColor: Palette.grey,
          textEditingController: companyNameController,
          style: AppTypography.regular18(),
          hintTextStyle: AppTypography.regular18(),
          hintText: 'Company Name',
          keyboardType: TextInputType.name,
          validator: InputValidators.name,
          autocorrect: false,
        ),
        InputFormField(
          fillColor: Palette.secondary,
          borderColor: Palette.grey,
          textEditingController: emailController,
          style: AppTypography.regular18(),
          hintTextStyle: AppTypography.regular18(),
          hintText: 'Email address',
          keyboardType: TextInputType.emailAddress,
          validator: InputValidators.email,
          autocorrect: false,
        ),
        InputFormField(
          fillColor: Palette.secondary,
          borderColor: Palette.grey,
          textEditingController: phoneController,
          style: AppTypography.regular18(),
          hintTextStyle: AppTypography.regular18(),
          hintText: 'Phone number',
          keyboardType: TextInputType.phone,
          validator: InputValidators.phone,
          autocorrect: false,
        ),
      ],
    );
  }
}
