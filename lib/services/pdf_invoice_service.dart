import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_market/model/cart_item_model.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';


Future<void> requestManageStoragePermission() async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    await Permission.manageExternalStorage.request();
  }
}


// Future<String> generateInvoicePdf(ObservableList<CartItem> cartItems) async {
//   var status = await Permission.manageExternalStorage.status;
//   if (!status.isGranted) {
//     await Permission.manageExternalStorage.request();
//   }
//
//   if (await Permission.manageExternalStorage.isGranted) {
//     final pdf = pw.Document();
//     final totalPrice = cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
//
//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.Table.fromTextArray(
//             headers: ['Product', 'Price', 'Quantity', 'Total'],
//             data: cartItems.map((item) => [
//               item.product.name['en'] ?? 'No name', // Usando nomes em inglês como exemplo
//               '\$${item.product.price.toStringAsFixed(2)}',
//               item.amount.toString(),
//               '\$${item.totalPrice.toStringAsFixed(2)}',
//             ]).toList()
//               ..add(['', '', 'Total', '\$${totalPrice.toStringAsFixed(2)}']),
//           ),
//         ],
//       ),
//     );
//
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/invoice.pdf');
//     await file.writeAsBytes(await pdf.save());
//     return file.path;
//   }
//   else {
//     // A permissão foi negada; trate a negação de permissão aqui
//     return 'Permission Denied';
//   }
// }

void generatePdf(List<CartItem> cartItems) async {
  try {
    final filePath = await generateInvoicePdf(cartItems);
    OpenFile.open(filePath);
  } catch (error) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Error generating PDF: ${error.toString()}"))
    // );

    print("Error generating PDF: ${error.toString()}");
  }
}

Future<String> generateInvoicePdf(List<CartItem> cartItems) async {
  var status = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    await Permission.manageExternalStorage.request();
  }

  if (await Permission.manageExternalStorage.isGranted) {
    try {
      final pdf = pw.Document();

      // Carregar a fonte Unicode
      final font = await rootBundle.load("lib/view/assets/fonts/Roboto-Regular.ttf");
      final ttf = pw.Font.ttf(font);

      final totalPrice = cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
      print('chegou aqui corretamente');

      pdf.addPage(
        pw.MultiPage(
          theme: pw.ThemeData.withFont(
            base: ttf, // Usar a fonte carregada como a fonte base
          ),
          build: (context) => [
            pw.Table.fromTextArray(
              headers: ['Product', 'Price', 'Quantity', 'Total'],
              data: cartItems.map((item) => [
                item.product.name['en'] ?? 'No name',
                '\$${item.product.price.toStringAsFixed(2)}',
                item.amount.toString(),
                '\$${item.totalPrice.toStringAsFixed(2)}',
              ]).toList()
                ..add(['', '', 'Total', '\$${totalPrice.toStringAsFixed(2)}']),
              // Certifique-se de que qualquer texto que você adicionar aqui também use a fonte Unicode, se necessário
            ),
          ],
        ),
      );

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/invoice.pdf');
      await file.writeAsBytes(await pdf.save());
      print(file.path);
      return file.path;
    } catch (error) {
      print(error.toString());
      return 'Error generating PDF: ${error.toString()}';
    }
  } else {
    print('permissão');

    return 'Permission Denied';
  }
}

