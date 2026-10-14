# Aula 3 (BRADEMO) - Material App e Navegação

Entrega dos três exercícios das páginas 63 a 66 dos slides. Cada exercício está em uma pasta própria e possui seu próprio `pubspec.yaml` e `lib/main.dart`.

## Projetos

1. **`exercicio_01_theme_azul`** — configura `ThemeData.scaffoldBackgroundColor` como azul.
2. **`exercicio_02_theme_sobrescrito`** — mantém o tema inicial azul e usa um `Theme` descendente com um `ThemeData` derivado por `copyWith`, sobrescrevendo o fundo para amarelo.
3. **`exercicio_03_login_navegacao`** — tela de login modularizada como sugerido no slide 66. Usuário `admin` e senha `1234` abrem a tela inicial; credenciais incorretas exibem um `SnackBar`.

## Executar

É necessário ter Flutter instalado. Entre na pasta do exercício que deseja executar e rode:

```bash
flutter pub get
flutter run
```

Os projetos contêm os arquivos de aplicação e dependências, mas não incluem os diretórios de plataforma gerados automaticamente pelo Flutter (`android/`, `ios/`, `web/`, etc.). Para gerar esses diretórios para Android, iOS e Web, execute **dentro de cada pasta de projeto**:

```bash
flutter create . --platforms=android,ios,web
```

Depois, execute `flutter pub get` e `flutter run`. No macOS, também é possível gerar suporte nativo para macOS acrescentando `macos` à lista de plataformas.

## Organização do exercício 3

```text
exercicio_03_login_navegacao/
├── assets/
│   └── logo.png
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── login.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   └── login_screen.dart
│   └── widgets/
│       └── login_form.dart
└── pubspec.yaml
```

> As credenciais são fixas de propósito para cumprir o enunciado da atividade; não representam autenticação segura para um aplicativo real.
