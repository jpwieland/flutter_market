import 'dart:io';
import 'package:flutter_market/model/cart_item_model.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<String> generateInvoicePdf(ObservableList<CartItem> cartItems) async {
  final pdf = pw.Document();
  final totalPrice = cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);

  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Table.fromTextArray(
          headers: ['Product', 'Price', 'Quantity', 'Total'],
          data: cartItems.map((item) => [
            item.product.name['en'] ?? 'No name', // Usando nomes em inglês como exemplo
            '\$${item.product.price.toStringAsFixed(2)}',
            item.amount.toString(),
            '\$${item.totalPrice.toStringAsFixed(2)}',
          ]).toList()
            ..add(['', '', 'Total', '\$${totalPrice.toStringAsFixed(2)}']),
        ),
      ],
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/invoice.pdf');
  await file.writeAsBytes(await pdf.save());
  return file.path;
}
