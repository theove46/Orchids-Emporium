// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

part of '../pages/pin_number_page.dart';

class _PinNumberCard extends StatefulWidget {
  const _PinNumberCard({
    required this.pinNumberController,
    required this.formKey,
    required this.userData,
    required this.totalPrice,
    required this.phoneNumber,
  });

  final TextEditingController pinNumberController;
  final GlobalKey<FormState> formKey;

  final dynamic userData;
  final double totalPrice;
  final String phoneNumber;

  @override
  State<_PinNumberCard> createState() => _PinNumberCardState();
}

class _PinNumberCardState extends State<_PinNumberCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.pinkColor,
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
    return const Text(
      'Enter 5 digit PIN number of your account',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _verificationNumberField() {
    return InputFormField(
      textEditingController: widget.pinNumberController,
      style: const TextStyle(
        fontSize: 24,
        color: Palette.greyColor,
      ),
      hintText: '     bKash PIN number',
      hintTextStyle: const TextStyle(
        fontSize: 24,
        color: Palette.greyColor,
      ),
      autocorrect: false,
      keyboardType: TextInputType.number,
      validator: InputValidators.otp,
      textAlign: TextAlign.center,
      maxLength: 5,
      obscureText: true,
    );
  }

  Widget _subtitleText() {
    return const Text(
      "Do not share your PIN number to anyone",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      color: Palette.greenwhiteColor.withOpacity(0.9),
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
      child: const Expanded(
        child: Text(
          'CLOSE',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return GestureDetector(
            onTap: () {
              if (widget.pinNumberController.text.length == 5) {
                EasyLoading.show(status: 'Placing Order');

                cartProvider.getCartItem.forEach(
                  (key, item) {
                    final orderId = const Uuid().v4();
                    firestore.collection('orders').doc(orderId).set({
                      'orderId': orderId,
                      'vendorId': item.vendorId,
                      'buyerEmail': data['email'],
                      'buyerPhone': data['phone'],
                      'buyerAddress': data['address'],
                      'buyerId': data['buyerId'],
                      'buyerName': data['fullName'],
                      'buyerPhoto': data['profileImage'],
                      'productName': item.productName,
                      'productPrice': item.price,
                      'productImage': item.imageUrl,
                      'productId': item.productId,
                      'quantity': item.quantity,
                      'orderDate': DateTime.now(),
                      'accepted': false,
                    }).whenComplete(
                      () {
                        EasyLoading.dismiss();

                        setState(() {
                          cartProvider.getCartItem.clear();
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PaymentSuccessPage(
                                userData: widget.userData,
                                totalPrice: widget.totalPrice,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                ShowSnackBarMessage.showErrorSnackBar(
                  message: 'Please enter correct PIN number',
                  context: context,
                );
              }
            },
            child: const Expanded(
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          );
        }
        return const Expanded(
          child: Text(
            'CONTINUE',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}
