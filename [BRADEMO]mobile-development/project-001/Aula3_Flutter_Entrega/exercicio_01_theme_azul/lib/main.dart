import 'package:flutter/material.dart';

void main() {
  runApp(const BlueThemeApp());
}

class BlueThemeApp extends StatelessWidget {
  const BlueThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 1 - ThemeData Azul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
      ),
      home: const BlueBackgroundPage(),
    );
  }
}

class BlueBackgroundPage extends StatelessWidget {
  const BlueBackgroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 1 - Tema azul'),
      ),
      body: Center(
        child: Container(
          width: 220,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            border: Border.all(color: Colors.amber, width: 2),
          ),
          child: const Text(
            'Background azul',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
