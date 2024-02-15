import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Color(0xFF094a87), // Polynesian blue
      scaffoldBackgroundColor: Color(0xFF061741), // Oxford Blue
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFF094a87), // Polynesian blue
        secondary: Color(0xFF78ed1a), // Lawn green, substituto para accentColor
        background: Color(0xFF061741), // Oxford Blue
        onPrimary: Color(0xFFfdfefe), // White, recomendado para texto/icones em cima do primary
        onSecondary: Color(0xFF061741), // Oxford Blue, recomendado para texto/icones em cima do secondary
      ),

      // Define o tema para os botões
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF78ed1a), // Lawn green
        textTheme: ButtonTextTheme.primary,
      ),

      // Define o tema para os textos
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Color(0xFFfdfefe)), // White
        bodyText2: TextStyle(color: Color(0xFFc0fcfd)), // Celeste
        headline1: TextStyle(color: Color(0xFF094a87)), // Polynesian blue
      ),

      // Define o estilo para os campos de texto
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Color(0xFF094a87)), // Polynesian blue
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFc0fcfd)), // Celeste
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF78ed1a)), // Lawn green
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFc0fcfd)), // Celeste
        ),
      ),

      // Define o tema para os ícones dentro dos campos de texto
      iconTheme: IconThemeData(
        color: Color(0xFFc0fcfd), // Celeste
      ),
    );
  }
}
