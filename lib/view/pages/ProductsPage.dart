import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/model/product_model.dart';
import 'package:flutter_market/store/cart/cart_store.dart';
import 'package:flutter_market/view/utils%20/custom_bottom_sheet_widget.dart';
import 'package:flutter_market/view/utils%20/custom_drawer_widget.dart';
import 'package:flutter_market/view/utils%20/quantity_selector_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductScreen extends StatelessWidget {
  final CartStore cartStore = CartStore();
  final List<Product> products = [
    Product(
      imageUrl:'lib/view/assets/products/apple.png',
      name: {'pt': 'Maçã', 'en': 'Apple'},
      price: 1.00,
    ),
    Product(
      imageUrl: 'lib/view/assets/products/pear.png',
      name: {'pt': 'Pêra', 'en': 'Pear'},
      price: 1.50,
    ),
    Product(
      imageUrl:'lib/view/assets/products/banana.png',
      name: {'pt': 'Banana', 'en': 'Banana'},
      price: 0.50,
    ),
    Product(
      imageUrl:'lib/view/assets/products/pineapple.png',
      name: {'pt': 'Abacaxi', 'en': 'Pineapple'},
      price: 3.00,
    ),
    Product(
      imageUrl:'lib/view/assets/products/mango.png',
      name: {'pt': 'Manga', 'en': 'Mango'},
      price: 2.00,
    ),
  ];



  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CustomBottomSheet(cartStore: cartStore),
      isScrollControlled: true,
    ).then((_) {
      if (cartStore.isBottomSheetOpen) {
        cartStore.toggleBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
        ),
        actions: [
          Observer(
            builder: (_) => Stack(
              children: [
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      cartStore.toggleBottomSheet();
                      print(cartStore.isBottomSheetOpen);
                      if (cartStore.isBottomSheetOpen) {
                        _showBottomSheet(context); // Exibe o bottom sheet
                      }
                    }),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartStore.totalItems}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(product.imageUrl, height: 100),
                Text(product.name['en'] ?? 'No name'), // Example for English
                Text('R\$ ${product.price.toStringAsFixed(2)}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => cartStore.addToCart(product),
                ),
                //QuantitySelector(cartStore: cartStore, product: product),
              ],
            ),
          );
        },
      ),
    );
  }
}
