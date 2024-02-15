import 'package:flutter_market/model/product_model.dart';

class CartItem {
  Product product;
  int amount;

  CartItem({required this.product, required this.amount});

  double get totalPrice {
    double rawTotal = amount * product.price;
    String roundedTotal = rawTotal.toStringAsFixed(2);

    return double.parse(roundedTotal);
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.name}, amount: $amount, totalPrice: \$${totalPrice})';
  }
}
