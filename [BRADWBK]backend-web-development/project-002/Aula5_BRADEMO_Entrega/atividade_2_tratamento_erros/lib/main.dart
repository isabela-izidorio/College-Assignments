import 'package:flutter/material.dart';

void main() => runApp(const ErrorHandlingApp());

class ErrorHandlingApp extends StatelessWidget {
  const ErrorHandlingApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Atividade 2 — erros assíncronos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange), useMaterial3: true),
        home: const ErrorHandlingPage(),
      );
}

class ErrorHandlingPage extends StatefulWidget {
  const ErrorHandlingPage({super.key});
  @override
  State<ErrorHandlingPage> createState() => _ErrorHandlingPageState();
}

class _ErrorHandlingPageState extends State<ErrorHandlingPage> {
  String _result = 'Escolha uma opção para executar changeUsername().';
  bool _loading = false;
  bool _simulateFailure = true;

  Future<String> fetchNewUsername() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (_simulateFailure) throw UserError();
    return 'jane_smith_92';
  }

  // Implementação do exercício: retorna o valor ou transforma o erro em String.
  Future<String> changeUsername() async {
    try {
      return await fetchNewUsername();
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> _run() async {
    setState(() => _loading = true);
    final result = await changeUsername();
    if (!mounted) return;
    setState(() {
      _result = result;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Atividade 2 • try/catch')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const Icon(Icons.shield_outlined, size: 64),
          const SizedBox(height: 12),
          Text('Tratamento de erros assíncronos', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          const Text('changeUsername() aguarda fetchNewUsername() e captura qualquer erro com try/catch, retornando a mensagem como texto.', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Simular falha da operação'),
            subtitle: Text(_simulateFailure ? 'A chamada lançará UserError.' : 'A chamada retornará um nome válido.'),
            value: _simulateFailure,
            onChanged: (value) => setState(() => _simulateFailure = value),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: _loading ? null : _run, icon: const Icon(Icons.play_arrow), label: Text(_loading ? 'Executando...' : 'Executar changeUsername()')),
          const SizedBox(height: 20),
          Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Resultado', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 10), SelectableText(_result)]))),
          const SizedBox(height: 12),
          const Text('O cenário padrão reproduz o exercício, em que a operação lança uma exceção. Desative a opção para verificar também o caminho de sucesso.'),
        ]),
      );
}

class UserError implements Exception {
  @override
  String toString() => 'New username is invalid';
}
