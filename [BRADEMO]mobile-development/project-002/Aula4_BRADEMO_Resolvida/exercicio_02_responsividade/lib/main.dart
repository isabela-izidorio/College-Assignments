import 'package:flutter/material.dart';

void main() => runApp(const ResponsiveLayoutsApp());

class ResponsiveLayoutsApp extends StatelessWidget {
  const ResponsiveLayoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Layouts',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const ResponsiveLayoutsPage(),
    );
  }
}

class ResponsiveLayoutsPage extends StatelessWidget {
  const ResponsiveLayoutsPage({super.key});

  static const List<String> languages = ['Dart', 'JavaScript', 'PHP', 'C++'];

  Widget _actionButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(110, 44),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () {},
      child: Text(label),
    );
  }

  Widget _languageList({required bool compact}) {
    return Column(
      mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
      children: [
        for (var i = 0; i < languages.length; i++) ...[
          if (compact)
            SizedBox(
              height: 54,
              child: Center(child: Text(languages[i], style: const TextStyle(fontSize: 17))),
            )
          else
            Expanded(child: Center(child: Text(languages[i], style: const TextStyle(fontSize: 17)))),
          if (i != languages.length - 1) const Divider(height: 1, color: Colors.white38),
        ],
      ],
    );
  }

  Widget _portraitLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 34),
          const Text('Cheetah Coding', style: TextStyle(fontSize: 23)),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(child: _actionButton('BUTTON 1')),
                const SizedBox(width: 12),
                Expanded(child: _actionButton('BUTTON 2')),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _languageList(compact: true),
        ],
      ),
    );
  }

  Widget _landscapeLayout() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Cheetah Coding', textAlign: TextAlign.center, style: TextStyle(fontSize: 23)),
                const SizedBox(height: 26),
                _actionButton('BUTTON 1'),
                const SizedBox(height: 14),
                _actionButton('BUTTON 2'),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 1, color: Colors.white54),
        Expanded(child: _languageList(compact: false)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Responsive Layouts', style: TextStyle(fontSize: 14)),
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 48,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) return _landscapeLayout();
          return _portraitLayout();
        },
      ),
    );
  }
}
