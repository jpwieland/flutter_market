import 'package:flutter/material.dart';
import 'package:flutter_market/model/cart_item_model.dart';
import 'package:flutter_market/services/pdf_invoice_service.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_market/store/cart/cart_store.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomBottomSheet extends StatelessWidget {
  final CartStore cartStore;

  CustomBottomSheet({required this.cartStore});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8, // Ajusta a altura para 80% da tela
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Observer(
              builder: (_) => ListView.builder(
                itemCount: cartStore.cartItems.length + 1, // Aumenta o itemCount por 1 para incluir a linha de total
                itemBuilder: (context, index) {
                  if (index < cartStore.cartItems.length) {
                    final cartItem = cartStore.cartItems[index];
                    return ListTile(
                      leading: Image.asset(cartItem.product.imageUrl, width: 50, height: 50),
                      title: Text(cartItem.product.name['en'] ?? 'No name'),
                      subtitle: Text('R\$ ${(cartItem.product.price * cartItem.amount).toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              cartStore.removeFromCart(cartItem.product);
                            },
                          ),
                          Text('${cartItem.amount}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cartStore.addToCart(cartItem.product);
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Observer(
                        builder: (_) => Text(
                          'R\$ ${cartStore.totalCost.toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  generatePdf(cartStore.cartItems);
                },
                child: Text('Generate Invoice'),
              ),
            ),
          ),
        ],
      ),
    );
  }

}



