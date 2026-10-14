import 'package:flutter/material.dart';

import '../models/login.dart';

/// Formulário reutilizável que coleta as credenciais e as entrega à tela.
class LoginForm extends StatefulWidget {
  const LoginForm({required this.onSubmit, super.key});

  final ValueChanged<Login> onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSubmit(
      Login(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Usuário',
              prefixIcon: Icon(Icons.person_outline),
            ),
            textInputAction: TextInputAction.next,
            autocorrect: false,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe o usuário.';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Senha',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a senha.';
              }
              return null;
            },
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
