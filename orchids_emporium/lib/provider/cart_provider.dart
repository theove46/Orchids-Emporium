import 'package:flutter/material.dart';
import 'package:orchids_emporium/users/model/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartAttribute> _cartItems = {};
  Map<String, CartAttribute> get getCartItem {
    return _cartItems;
  }

  double get totalPrice {
    var total = 0.00;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorId,
    String brandName,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCart) => CartAttribute(
          productName: existingCart.productName,
          productId: existingCart.productId,
          imageUrl: existingCart.imageUrl,
          quantity: existingCart.quantity + 1,
          productQuantity: existingCart.productQuantity,
          price: existingCart.price,
          vendorId: existingCart.vendorId,
          brandName: existingCart.brandName,
        ),
      );
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttribute(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          quantity: quantity,
          productQuantity: productQuantity,
          price: price,
          vendorId: vendorId,
          brandName: brandName,
        ),
      );
      notifyListeners();
    }
  }

  void increament(CartAttribute cartAttribute) {
    cartAttribute.increase();
    notifyListeners();
  }

  void decreament(CartAttribute cartAttribute) {
    cartAttribute.decrease();
    notifyListeners();
  }

  removeItem(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  removeAllItem() {
    _cartItems.clear();
    notifyListeners();
  }
}
