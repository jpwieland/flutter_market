import 'package:flutter/material.dart';
import 'package:flutter_market/store/cart/cart_store.dart';

class CustomBottomSheet extends StatelessWidget {
  final CartStore cartStore;

  CustomBottomSheet({required this.cartStore});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        itemCount: cartStore.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartStore.cartItems[index];
          return ListTile(
            leading: Image.network(cartItem.product.imageUrl, width: 50, height: 50),
            title: Text(cartItem.product.name['en'] ?? 'No name'),
            subtitle: Text('\$${(cartItem.product.price * cartItem.amount).toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    cartStore.removeFromCart(cartItem.product);
                  },
                ),
                Text('${cartItem.amount}'), // Quantidade
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    cartStore.addToCart(cartItem.product);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


