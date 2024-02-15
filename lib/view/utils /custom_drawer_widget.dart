import 'package:flutter/material.dart';
import 'package:flutter_market/model/cart_item_model.dart';
import 'package:flutter_market/store/cart/cart_store.dart';
import 'package:mobx/mobx.dart';

// Seu CustomDrawer widget
class CustomDrawer extends StatelessWidget {
  final CartStore cartStore;
  final ObservableList<CartItem> cartItems;

  CustomDrawer({required this.cartStore, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {  },
              //onPressed: () => cartStore.toggleDrawer(),
            ),
          ),
          Expanded(
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
          ),
          // Seu botão de Generate Invoice...
        ],
      ),
    );
  }
}
