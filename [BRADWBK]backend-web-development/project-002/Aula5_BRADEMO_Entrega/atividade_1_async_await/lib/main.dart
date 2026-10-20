import 'package:flutter/material.dart';

void main() => runApp(const AsyncAwaitApp());

class AsyncAwaitApp extends StatelessWidget {
  const AsyncAwaitApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Atividade 1 — async/await',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
        home: const AsyncAwaitPage(),
      );
}

class AsyncAwaitPage extends StatefulWidget {
  const AsyncAwaitPage({super.key});
  @override
  State<AsyncAwaitPage> createState() => _AsyncAwaitPageState();
}

class _AsyncAwaitPageState extends State<AsyncAwaitPage> {
  String _roleResult = 'Toque no botão para buscar o papel do usuário.';
  String _loginResult = 'Toque no botão para buscar a quantidade de logins.';
  bool _loadingRole = false;
  bool _loadingLogins = false;

  // Simula uma chamada assíncrona, como no exercício do tutorial Dart.
  Future<String> fetchRole() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return 'administrator';
  }

  Future<int> fetchLoginAmount() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return 42;
  }

  Future<String> reportUserRole() async {
    final role = await fetchRole();
    return 'User role: $role';
  }

  Future<String> reportLogins() async {
    final logins = await fetchLoginAmount();
    return 'Total number of logins: $logins';
  }

  Future<void> _loadRole() async {
    setState(() => _loadingRole = true);
    try {
      final result = await reportUserRole();
      if (!mounted) return;
      setState(() => _roleResult = result);
    } catch (error) {
      if (!mounted) return;
      setState(() => _roleResult = 'Erro: $error');
    } finally {
      if (mounted) setState(() => _loadingRole = false);
    }
  }

  Future<void> _loadLogins() async {
    setState(() => _loadingLogins = true);
    try {
      final result = await reportLogins();
      if (!mounted) return;
      setState(() => _loginResult = result);
    } catch (error) {
      if (!mounted) return;
      setState(() => _loginResult = 'Erro: $error');
    } finally {
      if (mounted) setState(() => _loadingLogins = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Atividade 1 • async/await')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const Icon(Icons.hourglass_top_rounded, size: 64),
          const SizedBox(height: 12),
          Text('Prática de operações assíncronas', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          const Text('As funções usam Future, async e await para aguardar os valores sem bloquear a interface.', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          _ResultCard(title: 'Papel do usuário', result: _roleResult),
          FilledButton.icon(onPressed: _loadingRole ? null : _loadRole, icon: const Icon(Icons.person_search), label: Text(_loadingRole ? 'Buscando...' : 'Executar reportUserRole()')),
          const SizedBox(height: 20),
          _ResultCard(title: 'Quantidade de logins', result: _loginResult),
          FilledButton.icon(onPressed: _loadingLogins ? null : _loadLogins, icon: const Icon(Icons.numbers), label: Text(_loadingLogins ? 'Buscando...' : 'Executar reportLogins()')),
        ]),
      );
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.title, required this.result});
  final String title;
  final String result;
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8), SelectableText(result)])),
      );
}
