import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.username, super.key});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter By Example')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 280,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                'Bem-vindo, $username!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text('Login realizado com sucesso.'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Mostrar mensagem',
        onPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Você está na página inicial.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
        },
        child: const Icon(Icons.star),
      ),
    );
  }
}
