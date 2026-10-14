import 'package:flutter/material.dart';

void main() => runApp(const FabNavigationApp());

class FabNavigationApp extends StatelessWidget {
  const FabNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomAppBar with FAB',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
      home: const FabNavigationPage(),
    );
  }
}

class FabNavigationPage extends StatefulWidget {
  const FabNavigationPage({super.key});

  @override
  State<FabNavigationPage> createState() => _FabNavigationPageState();
}

class _FabNavigationPageState extends State<FabNavigationPage> {
  int _selectedTab = 2;
  bool _showActions = false;

  static const _tabs = [
    _NavItem(icon: Icons.menu, label: 'This'),
    _NavItem(icon: Icons.layers, label: 'Is'),
    _NavItem(icon: Icons.dashboard, label: 'Bottom'),
    _NavItem(icon: Icons.info, label: 'Bar'),
  ];

  void _selectTab(int index) => setState(() => _selectedTab = index);

  void _performAction(String label) {
    setState(() => _showActions = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opção selecionada: $label')));
  }

  Widget _tabButton(int index) {
    final item = _tabs[index];
    final selected = _selectedTab == index;
    final color = selected ? Colors.red : Colors.grey.shade600;
    return Expanded(
      child: InkWell(
        onTap: () => _selectTab(index),
        child: SizedBox(
          height: 62,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(item.icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(item.label, style: TextStyle(fontSize: 11, color: color)),
          ]),
        ),
      ),
    );
  }

  Widget _actionOption({required String label, required IconData icon, required String heroTag}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), child: Text(label, style: const TextStyle(fontSize: 12))),
        ),
        const SizedBox(width: 12),
        FloatingActionButton.small(
          heroTag: heroTag,
          backgroundColor: Colors.white,
          foregroundColor: Colors.lightBlue.shade800,
          onPressed: () => _performAction(label),
          child: Icon(icon),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomAppBar with FAB'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Center(child: Text('TAB: ${_selectedTab + 1}', style: const TextStyle(fontSize: 26, color: Colors.black87))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [
        if (_showActions) ...[
          _actionOption(label: 'Mensagem', icon: Icons.message, heroTag: 'fab_message'),
          _actionOption(label: 'E-mail', icon: Icons.email, heroTag: 'fab_email'),
          _actionOption(label: 'Telefone', icon: Icons.phone, heroTag: 'fab_phone'),
          const SizedBox(height: 4),
        ],
        FloatingActionButton(
          heroTag: 'fab_main',
          onPressed: () => setState(() => _showActions = !_showActions),
          tooltip: _showActions ? 'Fechar opções' : 'Abrir opções',
          child: Icon(_showActions ? Icons.close : Icons.add),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        color: Colors.white,
        child: Row(children: [
          _tabButton(0),
          _tabButton(1),
          const SizedBox(width: 54),
          _tabButton(2),
          _tabButton(3),
        ]),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
