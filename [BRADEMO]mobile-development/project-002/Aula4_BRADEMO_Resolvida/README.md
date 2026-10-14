# Aula 4 (BRADEMO) — atividade resolvida

O material contém **seis projetos Flutter separados**, correspondentes aos exercícios do final dos slides.

| Pasta | Exercício | O que foi implementado |
|---|---|---|
| `exercicio_01_gridview` | 1 | Grade rolável de imagens com `GridView.builder`, legendas e tratamento de carregamento/erro das imagens. |
| `exercicio_02_responsividade` | 2 | Interface que alterna entre layout vertical e duas colunas com `LayoutBuilder`. |
| `exercicio_03_constraints` | 3 | Explorador interativo com 29 exemplos de constraints, baseado na documentação oficial do Flutter. Os casos que causariam erro são apresentados de forma segura, sem derrubar o app. |
| `exercicio_04_form` | 4 | Formulário validado de nome, telefone e data de nascimento; o botão Submit mostra os dados em `SnackBar`. |
| `exercicio_05_bottom_bar_fab` | 5 | `BottomAppBar` com recorte, FAB centralizado, navegação entre abas e opções adicionais ao tocar no FAB. |
| `exercicio_06_lista_tarefas` | 6 | Lista de tarefas com `ListView.builder`, `Card`, `Checkbox`, `ElevatedButton` e `AlertDialog` solicitado. Permite marcar tarefas como concluídas e alternar entre tarefas pendentes/concluídas. |

## Como executar

Cada pasta contém seu próprio `pubspec.yaml` e `lib/main.dart`. Para executar um projeto:

1. Abra a pasta do exercício desejado no VS Code ou Android Studio.
2. Execute `flutter pub get`.
3. Execute `flutter run` e selecione um dispositivo.

Como o Flutter SDK não está presente no ambiente em que este arquivo foi montado, as pastas com os arquivos nativos específicos de Android/iOS/macOS/Windows/Linux não foram geradas aqui. Se precisar desses diretórios, execute o script opcional `./bootstrap_platforms.sh` na pasta raiz **em uma máquina com Flutter instalado**; ele gera as pastas de plataforma em cada projeto sem substituir os `main.dart`. Depois, abra e execute cada pasta normalmente.

O exercício 1 carrega imagens pela internet. O restante funciona localmente.

## Referências usadas

- Slides da Aula 4 (BRADEMO), exercícios 1 a 6.
- https://docs.flutter.dev/ui/layout/constraints
- https://codewithandrea.com/articles/bottom-bar-navigation-with-fab/
- https://docs.flutter.dev/cookbook/forms/retrieve-input
