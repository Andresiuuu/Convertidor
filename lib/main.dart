import 'package:flutter/material.dart';
import 'ui/interface.dart';

void main() {
  runApp(const ConversionApp());
}

class ConversionApp extends StatelessWidget {
  const ConversionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Sistemas Numéricos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 4,
          backgroundColor: Color.fromARGB(255, 97, 63, 94),
          foregroundColor: Colors.white,
        ),
      ),
      home: const NumberConverterInterface(),
      debugShowCheckedModeBanner: false,
    );
  }
}