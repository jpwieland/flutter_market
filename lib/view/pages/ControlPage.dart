import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_market/view/pages/DemoPage.dart';
import 'package:flutter_market/view/pages/LoginPage.dart';


class ControlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Verifica o estado de autenticação do Firebase
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // Se o snapshot tem dados e o usuário está logado
          if (snapshot.hasData && snapshot.data != null) {
            return DemoPage(); // Abre a DemoPage
          } else {
            return LoginPage(); // Abre a LoginPage
          }
        }

        // Enquanto espera para verificar o estado de autenticação, pode mostrar um loading spinner
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
