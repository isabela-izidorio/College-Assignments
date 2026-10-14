import 'package:flutter/material.dart';

void main() => runApp(const ConstraintsDemoApp());

const Color red = Colors.red;
const Color green = Colors.green;
const Color blue = Colors.blue;
const TextStyle big = TextStyle(fontSize: 28, color: Colors.black87);

class ConstraintsDemoApp extends StatelessWidget {
  const ConstraintsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Constraints',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const ConstraintsDemoPage(),
    );
  }
}

class LayoutExample {
  const LayoutExample({required this.title, required this.code, required this.explanation});
  final String title;
  final String code;
  final String explanation;
}

class ConstraintsDemoPage extends StatefulWidget {
  const ConstraintsDemoPage({super.key});

  @override
  State<ConstraintsDemoPage> createState() => _ConstraintsDemoPageState();
}

class _ConstraintsDemoPageState extends State<ConstraintsDemoPage> {
  int _selected = 0;

  static const List<LayoutExample> examples = [
    LayoutExample(title: 'Container ocupa o espaço disponível', code: r'Container(color: red)', explanation: 'A tela fornece constraints apertadas ao Container. Como o pai exige o tamanho disponível, ele preenche toda a área de demonstração.'),
    LayoutExample(title: 'Tamanho solicitado pelo filho', code: r'Container(width: 100, height: 100, color: red)', explanation: 'Definir width e height não garante esse tamanho se o pai impuser constraints apertadas. O tamanho imposto pelo pai prevalece.'),
    LayoutExample(title: 'Center libera o tamanho do filho', code: r'Center(child: Container(width: 100, height: 100, color: red))', explanation: 'Center ocupa o espaço disponível e permite ao filho ter um tamanho menor. Assim, o Container pode medir 100 × 100.'),
    LayoutExample(title: 'Align posiciona no canto', code: r'Align(alignment: Alignment.bottomRight, child: Container(width: 100, height: 100, color: red))', explanation: 'Align permite que o filho seja menor que a área e o posiciona no canto inferior direito.'),
    LayoutExample(title: 'double.infinity com Center', code: r'Center(child: Container(width: double.infinity, height: double.infinity, color: red))', explanation: 'O Container deseja ocupar um tamanho infinito, mas Center limita o filho ao tamanho máximo disponível.'),
    LayoutExample(title: 'Container sem tamanho explícito', code: r'Center(child: Container(color: red))', explanation: 'Um Container sem tamanho próprio nem filho tende a ocupar o máximo que as constraints flexíveis permitem.'),
    LayoutExample(title: 'Container pai do tamanho do filho', code: r'Center(child: Container(color: red, child: Container(color: green, width: 30, height: 30)))', explanation: 'Sem tamanho definido, o Container vermelho se ajusta ao filho verde de 30 × 30. O verde cobre a área vermelha.'),
    LayoutExample(title: 'Padding altera o tamanho total', code: r'Center(child: Container(color: red, padding: EdgeInsets.all(20), child: Container(color: green, width: 30, height: 30)))', explanation: 'O Container vermelho envolve o filho e soma o padding de 20 pixels em cada lado ao tamanho total.'),
    LayoutExample(title: 'ConstrainedBox sob constraints apertadas', code: r'ConstrainedBox(constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 10, height: 10))', explanation: 'Sem um pai que solte as constraints, a tela ainda pode obrigar o ConstrainedBox a preencher o espaço; as constraints adicionais não anulam as do pai.'),
    LayoutExample(title: 'ConstrainedBox aplica mínimos', code: r'Center(child: ConstrainedBox(constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 10, height: 10)))', explanation: 'Center permite que o ConstrainedBox seja menor que a área disponível. Como o Container pede 10 × 10, o mínimo da caixa o leva a 70 × 70.'),
    LayoutExample(title: 'ConstrainedBox aplica máximos', code: r'Center(child: ConstrainedBox(constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 1000, height: 1000)))', explanation: 'Mesmo pedindo 1000 × 1000, o Container fica limitado ao máximo de 150 × 150.'),
    LayoutExample(title: 'Tamanho dentro do intervalo', code: r'Center(child: ConstrainedBox(constraints: BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 100, height: 100)))', explanation: 'Quando o tamanho solicitado está entre o mínimo e o máximo, o Container pode mantê-lo: neste caso 100 × 100.'),
    LayoutExample(title: 'UnconstrainedBox libera o filho', code: r'UnconstrainedBox(child: Container(color: red, width: 20, height: 50))', explanation: 'UnconstrainedBox ocupa a área do pai, mas deixa o filho escolher livremente o tamanho indicado de 20 × 50.'),
    LayoutExample(title: 'Filho maior que a tela', code: r'UnconstrainedBox(child: Container(color: red, width: 4000, height: 50))', explanation: 'O filho tem 4000 pixels de largura. O exemplo pode ultrapassar a área disponível e provocar um aviso visual de overflow; a prévia é recortada para manter a atividade estável.'),
    LayoutExample(title: 'OverflowBox permite ultrapassar limites', code: r'OverflowBox(minWidth: 0, minHeight: 0, maxWidth: double.infinity, maxHeight: double.infinity, child: Container(color: red, width: 4000, height: 50))', explanation: 'OverflowBox permite ao filho ser maior que a área apresentada sem o aviso de overflow do UnconstrainedBox; apenas a parte visível aparece na prévia.'),
    LayoutExample(title: 'Largura infinita sem limite', code: r'UnconstrainedBox(child: Container(color: red, width: double.infinity, height: 100))', explanation: 'Esse código original produz erro porque um filho sem limite horizontal não pode definir sua largura como infinito. A prévia mostra a situação sem executar a configuração inválida.'),
    LayoutExample(title: 'LimitedBox limita constraints infinitas', code: r'UnconstrainedBox(child: LimitedBox(maxWidth: 100, child: Container(color: red, width: double.infinity, height: 100)))', explanation: 'LimitedBox aplica o máximo de 100 pixels quando recebe uma largura ilimitada. Diferente de ConstrainedBox, o limite depende de receber constraints infinitas.'),
    LayoutExample(title: 'FittedBox escala o texto', code: r'FittedBox(child: Text("Some Example Text."))', explanation: 'FittedBox deixa o texto medir seu tamanho natural e depois o escala para caber no espaço disponível.'),
    LayoutExample(title: 'FittedBox dentro de Center', code: r'Center(child: FittedBox(child: Text("Some Example Text.")))', explanation: 'Center permite ao FittedBox ajustar-se ao texto. Como ambos podem acabar com o mesmo tamanho, não é necessário escalar o conteúdo.'),
    LayoutExample(title: 'FittedBox com texto muito longo', code: r'Center(child: FittedBox(child: Text("This is some very very very large text...")))', explanation: 'Quando o texto é maior que a tela, FittedBox respeita o limite da tela e reduz o texto para fazê-lo caber.'),
    LayoutExample(title: 'Texto longo sem FittedBox', code: r'Center(child: Text("This is some very very very large text..."))', explanation: 'Sem FittedBox, o texto recebe a largura máxima e quebra em linhas para caber no espaço.'),
    LayoutExample(title: 'FittedBox precisa de limites finitos', code: r'FittedBox(child: Container(height: 20, width: double.infinity, color: red))', explanation: 'FittedBox precisa de um filho com largura e altura limitadas. A versão original com largura infinita gera erro; a prévia representa a situação com tamanho finito.'),
    LayoutExample(title: 'Row com filhos do tamanho natural', code: r'Row(children: [Container(color: red, child: Text("Hello!")), Container(color: green, child: Text("Goodbye!"))])', explanation: 'Row posiciona os filhos lado a lado sem impor a eles uma largura fixa; cada filho usa o tamanho que solicitar.'),
    LayoutExample(title: 'Row pode exceder a largura', code: r'Row(children: [Container(color: red, child: Text("This is a very long text that will not fit the line.")), Container(color: green, child: Text("Goodbye!"))])', explanation: 'Se os filhos somarem uma largura maior que a disponível, Row pode mostrar o aviso de overflow. A prévia é recortada.'),
    LayoutExample(title: 'Expanded ocupa o espaço restante', code: r'Row(children: [Expanded(child: Container(color: red, child: Text("A long text"))), Container(color: green, child: Text("Goodbye!"))])', explanation: 'Expanded define a largura disponível para o filho depois de considerar os outros filhos da Row; a largura natural do conteúdo deixa de controlar o espaço.'),
    LayoutExample(title: 'Dois Expanded dividem a linha', code: r'Row(children: [Expanded(child: Container(color: red, child: Text("A long text"))), Expanded(child: Container(color: green, child: Text("Goodbye!")))])', explanation: 'Quando todos os filhos usam Expanded com o mesmo flex, a largura disponível é dividida igualmente entre eles.'),
    LayoutExample(title: 'Flexible permite filho menor', code: r'Row(children: [Flexible(child: Container(color: red, child: Text("A long text"))), Flexible(child: Container(color: green, child: Text("Goodbye!")))])', explanation: 'Flexible limita o espaço do filho, mas permite que ele ocupe menos que o espaço atribuído. Expanded exige que o filho preencha esse espaço.'),
    LayoutExample(title: 'Scaffold e constraints flexíveis', code: r'Scaffold(body: Container(color: blue, child: Column(children: [Text("Hello!"), Text("Goodbye!")])))', explanation: 'Scaffold preenche a tela e passa constraints flexíveis ao Container do body. A Column contém os textos no topo, sem precisar preencher toda a altura.'),
    LayoutExample(title: 'SizedBox.expand impõe o tamanho', code: r'Scaffold(body: SizedBox.expand(child: Container(color: blue, child: Column(children: [Text("Hello!"), Text("Goodbye!")]))))', explanation: 'SizedBox.expand força o filho a ocupar toda a área do Scaffold, passando constraints apertadas para largura e altura.'),
  ];

  Widget _preview(int number) {
    switch (number) {
      case 1:
        return Container(color: red);
      case 2:
        return Container(width: 100, height: 100, color: red);
      case 3:
        return Center(child: Container(width: 100, height: 100, color: red));
      case 4:
        return Align(alignment: Alignment.bottomRight, child: Container(width: 100, height: 100, color: red));
      case 5:
        return Center(child: Container(width: double.infinity, height: double.infinity, color: red));
      case 6:
        return Center(child: Container(color: red));
      case 7:
        return Center(child: Container(color: red, child: Container(color: green, width: 30, height: 30)));
      case 8:
        return Center(child: Container(color: red, padding: const EdgeInsets.all(20), child: Container(color: green, width: 30, height: 30)));
      case 9:
        return ConstrainedBox(constraints: const BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 10, height: 10));
      case 10:
        return Center(child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 10, height: 10)));
      case 11:
        return Center(child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 1000, height: 1000)));
      case 12:
        return Center(child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150), child: Container(color: red, width: 100, height: 100)));
      case 13:
        return UnconstrainedBox(child: Container(color: red, width: 20, height: 50));
      case 14:
        return UnconstrainedBox(child: Container(color: red, width: 4000, height: 50));
      case 15:
        return OverflowBox(minWidth: 0, minHeight: 0, maxWidth: double.infinity, maxHeight: double.infinity, child: Container(color: red, width: 4000, height: 50));
      case 16:
        return Center(child: _invalidConstraintCard('width: double.infinity', 'Largura infinita sob constraints ilimitadas gera erro.'));
      case 17:
        return UnconstrainedBox(child: LimitedBox(maxWidth: 100, child: Container(color: red, width: double.infinity, height: 100)));
      case 18:
        return const FittedBox(child: Text('Some Example Text.', style: big));
      case 19:
        return const Center(child: FittedBox(child: Text('Some Example Text.', style: big)));
      case 20:
        return const Center(child: FittedBox(child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.', style: big)));
      case 21:
        return const Center(child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.', style: big));
      case 22:
        return Center(child: _invalidConstraintCard('FittedBox + largura infinita', 'O filho precisa ter largura e altura finitas.'));
      case 23:
        return Row(children: [Container(color: red, child: const Text('Hello!', style: big)), Container(color: green, child: const Text('Goodbye!', style: big))]);
      case 24:
        return Row(children: [Container(color: red, child: const Text('This is a very long text that will not fit the line.', style: big)), Container(color: green, child: const Text('Goodbye!', style: big))]);
      case 25:
        return Row(children: [Expanded(child: Center(child: Container(color: red, child: const Text('This is a very long text that will not fit the line.', style: big)))), Container(color: green, child: const Text('Goodbye!', style: big))]);
      case 26:
        return Row(children: [Expanded(child: Container(color: red, child: const Text('This is a very long text that will not fit the line.', style: big))), Expanded(child: Container(color: green, child: const Text('Goodbye!', style: big)))]);
      case 27:
        return Row(children: [Flexible(child: Container(color: red, child: const Text('This is a very long text that will not fit the line.', style: big))), Flexible(child: Container(color: green, child: const Text('Goodbye!', style: big)))]);
      case 28:
        return Scaffold(body: Container(color: blue, child: const Column(children: [Text('Hello!'), Text('Goodbye!')])));
      case 29:
        return Scaffold(body: SizedBox.expand(child: Container(color: blue, child: const Column(children: [Text('Hello!'), Text('Goodbye!')]))));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _invalidConstraintCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade700)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 36),
        const SizedBox(height: 8),
        Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(description, textAlign: TextAlign.center),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final example = examples[_selected];
    return Scaffold(
      appBar: AppBar(title: const Text('Constraints no Flutter'), centerTitle: false),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 6),
          child: Text('Constraints descem. Tamanhos sobem. O pai define a posição.', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: examples.length,
            separatorBuilder: (_, __) => const SizedBox(width: 5),
            itemBuilder: (context, index) => ChoiceChip(
              label: Text('${index + 1}'),
              selected: _selected == index,
              onSelected: (_) => setState(() => _selected = index),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
            child: ClipRect(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: const Color(0xFFF1F3F5), borderRadius: BorderRadius.circular(12)),
                child: LayoutBuilder(builder: (context, constraints) => SizedBox(width: constraints.maxWidth, height: constraints.maxHeight, child: _preview(_selected + 1))),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Exemplo ${_selected + 1} de ${examples.length}', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(example.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF20252B), borderRadius: BorderRadius.circular(8)),
                child: SelectableText(example.code, style: const TextStyle(color: Color(0xFFE2E8F0), fontFamily: 'monospace', fontSize: 12)),
              ),
              const SizedBox(height: 10),
              Text(example.explanation),
              const SizedBox(height: 10),
              const Text('Referência: docs.flutter.dev/ui/layout/constraints', style: TextStyle(fontSize: 11, color: Colors.black54)),
            ]),
          ),
        ),
      ]),
    );
  }
}
