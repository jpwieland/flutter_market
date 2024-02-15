import 'package:flutter/material.dart';
import 'package:flutter_market/services/pdf_invoice_service.dart';
import 'package:flutter_market/store/cart/cart_store.dart';
import 'package:open_file/open_file.dart';

class InvoiceButton extends StatelessWidget {
  final CartStore cartStore;

  InvoiceButton({required this.cartStore});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Generate Invoice'),
      onPressed: () async {
        final pdfPath = await generateInvoicePdf(cartStore.cartItems);
        await OpenFile.open(pdfPath);

        // Mostrar alerta após o retorno do visualizador de PDF
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Thank you for your preference"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o alerta
                    cartStore.clearCart(); // Limpa o carrinho
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
