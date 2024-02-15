import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market/firebase_options.dart';
import 'package:flutter_market/view/app_theme.dart';
import 'package:flutter_market/view/pages/ControlPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that you have a Flutter binding initialized.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market App',
      //theme: AppTheme.theme,
      home:  ControlPage(),
    );
  }
}

