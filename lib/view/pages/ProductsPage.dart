import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/model/product_model.dart';
import 'package:flutter_market/store/cart/cart_store.dart';
import 'package:flutter_market/view/utils%20/custom_drawer_widget.dart';
import 'package:flutter_market/view/utils%20/quantity_selector_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductScreen extends StatelessWidget {
  final CartStore cartStore = CartStore();
  final List<Product> products = [
    Product(
      imageUrl:
          'https://cdn.discordapp.com/attachments/1092803969354567782/1207677948740632606/image.png?ex=65e084bc&is=65ce0fbc&hm=a95f13ac0b6428cb85c38ac6ad540d37d77ade70dece1828e1fb28b63aa3f1d6&',
      name: {'pt': 'Maçã', 'en': 'Apple'},
      price: 1.00,
    ),
    Product(
      imageUrl:
          'https://cdn.discordapp.com/attachments/1092803969354567782/1207677949046951966/image.png?ex=65e084bc&is=65ce0fbc&hm=19cec83e43a7c1e91b2bb0385ce4a4f6e6958cef5bf87b8827635e8abaa2d726&',
      name: {'pt': 'Pêra', 'en': 'Pear'},
      price: 1.50,
    ),
    Product(
      imageUrl:
          'https://cdn.discordapp.com/attachments/1092803969354567782/1207677949336100874/image.png?ex=65e084bc&is=65ce0fbc&hm=c213b87a4bfd86a663ad0252ca86607279b85e717a2a2cb6416e20005f3adaf5&',
      name: {'pt': 'Banana', 'en': 'Banana'},
      price: 0.50,
    ),
    Product(
      imageUrl:
          'https://cdn.discordapp.com/attachments/1092803969354567782/1207677949663510641/image.png?ex=65e084bc&is=65ce0fbc&hm=191ada608fbc862987d3ab8e686f86b9b2537fa9bffcc2f032ffe9c8ad81c6e5&',
      name: {'pt': 'Abacaxi', 'en': 'Pineapple'},
      price: 3.00,
    ),
    Product(
      imageUrl:
          'https://media.discordapp.net/attachments/1092803969354567782/1207677949982285874/image.png?ex=65e084bc&is=65ce0fbc&hm=85186d0ce08559d0c890ebd378acbf5c058d37f41e20bc030cf7391bf6a64583&=&format=webp&quality=lossless&width=1224&height=896',
      name: {'pt': 'Manga', 'en': 'Mango'},
      price: 2.00,
    ),
  ];

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
                Image.network(product.imageUrl, height: 100),
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
