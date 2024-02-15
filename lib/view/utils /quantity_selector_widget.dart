import 'package:flutter/material.dart';
import 'package:flutter_market/model/cart_item_model.dart';
import 'package:flutter_market/model/product_model.dart';
import 'package:flutter_market/store/cart/cart_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class QuantitySelector extends StatelessWidget {
  final CartStore cartStore;
  final Product product;

  QuantitySelector({required this.cartStore, required this.product});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final cartItem = cartStore.cartItems.firstWhere(
            (item) => item.product == product,
      );
      final quantity = cartItem?.amount ?? 0;

      return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove, size: 18), // Tamanho do ícone reduzido
              onPressed: quantity > 0 ? () => cartStore.removeFromCart(product) : null,
            ),
            Text(
              '$quantity',
              style: TextStyle(fontSize: 14), // Tamanho da fonte ajustado
            ),
            IconButton(
              icon: Icon(Icons.add, size: 18), // Tamanho do ícone reduzido
              onPressed: () => cartStore.addToCart(product),
            ),
          ],
        ),
      );
    });
  }
}
