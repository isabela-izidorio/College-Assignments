import 'package:flutter/material.dart';

void main() => runApp(const FlutterFormApp());

class FlutterFormApp extends StatelessWidget {
  const FlutterFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Form Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const FlutterFormPage(),
    );
  }
}

class FlutterFormPage extends StatefulWidget {
  const FlutterFormPage({super.key});

  @override
  State<FlutterFormPage> createState() => _FlutterFormPageState();
}

class _FlutterFormPageState extends State<FlutterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _chooseDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Selecione a data de nascimento',
    );
    if (!mounted || picked == null) return;
    setState(() {
      _dateOfBirth = picked;
      _dobController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    });
  }

  Widget _inputRow({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 34, child: Icon(icon, color: Colors.blueGrey, size: 21)),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              readOnly: readOnly,
              onTap: onTap,
              validator: validator,
              decoration: InputDecoration(
                hintText: label,
                border: const UnderlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final message = 'Nome: ${_nameController.text.trim()} | Telefone: ${_phoneController.text.trim()} | Nascimento: ${_dobController.text}';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 5), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Demo'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _inputRow(
                    icon: Icons.person_outline,
                    label: 'Nome',
                    controller: _nameController,
                    validator: (value) => value == null || value.trim().isEmpty ? 'Informe seu nome.' : null,
                  ),
                  _inputRow(
                    icon: Icons.phone_outlined,
                    label: 'Telefone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.trim().isEmpty ? 'Informe seu telefone.' : null,
                  ),
                  _inputRow(
                    icon: Icons.calendar_month_outlined,
                    label: 'Data de nascimento',
                    controller: _dobController,
                    readOnly: true,
                    onTap: _chooseDate,
                    validator: (_) => _dateOfBirth == null ? 'Selecione sua data de nascimento.' : null,
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ElevatedButton(onPressed: _submit, child: const Padding(padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10), child: Text('Submit')))],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
