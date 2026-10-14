import 'package:flutter/material.dart';

void main() {
  runApp(const ThemeOverrideApp());
}

class ThemeOverrideApp extends StatelessWidget {
  const ThemeOverrideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 2 - Sobrescrita de tema',
      debugShowCheckedModeBanner: false,
      // Tema inicial: o background padrão dos Scaffolds é azul-claro.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
      ),
      home: const ThemeOverridePage(),
    );
  }
}

class ThemeOverridePage extends StatelessWidget {
  const ThemeOverridePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Exercício 2 - ThemeData sobrescrito'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bluePanel = const ThemePreview(
            title: 'Tema original',
            description: 'Background azul',
          );
          final yellowPanel = Theme(
            // Cria outro ThemeData com base no tema herdado, alterando somente
            // a cor de fundo para o widget descendente.
            data: Theme.of(context).copyWith(
              scaffoldBackgroundColor: Colors.yellow.shade200,
            ),
            child: const ThemePreview(
              title: 'Tema sobrescrito',
              description: 'Background amarelo',
            ),
          );

          final isWide = constraints.maxWidth >= 650;
          final panels = [
            Expanded(child: _panel(bluePanel)),
            SizedBox(width: isWide ? 16 : 0, height: isWide ? 0 : 16),
            Expanded(child: _panel(yellowPanel)),
          ];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: isWide
                ? Row(children: panels)
                : Column(children: panels),
          );
        },
      ),
    );
  }

  Widget _panel(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 1.5),
        ),
        child: child,
      ),
    );
  }
}

class ThemePreview extends StatelessWidget {
  const ThemePreview({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 180,
                height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
