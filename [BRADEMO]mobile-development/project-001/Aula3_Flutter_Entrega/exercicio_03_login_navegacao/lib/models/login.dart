/// Modelo simples para armazenar as credenciais informadas no formulário.
class Login {
  const Login({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  /// Credenciais fixas exigidas pelo enunciado da atividade.
  bool get isValid => username == 'admin' && password == '1234';
}
