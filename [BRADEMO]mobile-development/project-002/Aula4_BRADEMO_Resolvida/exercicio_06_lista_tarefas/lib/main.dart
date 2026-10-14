import 'package:flutter/material.dart';

void main() => runApp(const TaskNotesApp());

class TaskNotesApp extends StatelessWidget {
  const TaskNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notas de Tarefas',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const TaskNotesPage(),
    );
  }
}

class TaskItem {
  TaskItem({required this.title, required this.createdAt, this.completed = false});

  final String title;
  final DateTime createdAt;
  bool completed;
}

class TaskNotesPage extends StatefulWidget {
  const TaskNotesPage({super.key});

  @override
  State<TaskNotesPage> createState() => _TaskNotesPageState();
}

class _TaskNotesPageState extends State<TaskNotesPage> {
  final List<TaskItem> _tasks = List.generate(
    5,
    (index) => TaskItem(
      title: 'Tarefa ${index + 1}',
      createdAt: DateTime.now().subtract(Duration(minutes: index * 17)),
      completed: false,
    ),
  );
  bool _showCompleted = false;

  List<TaskItem> get _visibleTasks => _tasks.where((task) => _showCompleted ? task.completed : !task.completed).toList();
  int get _pendingCount => _tasks.where((task) => !task.completed).length;

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$day/$month/${value.year} às $hour:$minute';
  }

  void _toggleTask(TaskItem task, bool? checked) {
    setState(() => task.completed = checked ?? false);
  }

  Future<void> _showInfoDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sobre o aplicativo'),
        content: const Text('Você está no App de Notas de Tarefas'),
        actions: [TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Fechar'))],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final visibleTasks = _visibleTasks;
    return Scaffold(
      appBar: AppBar(title: const Text('Notas de Tarefas'), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: ElevatedButton(
              onPressed: () => setState(() => _showCompleted = !_showCompleted),
              child: Text(_showCompleted ? 'Ver tarefas pendentes' : 'Ver tarefas concluídas'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(_showCompleted ? 'Você concluiu ${_tasks.length - _pendingCount} tarefas' : 'Você tem $_pendingCount tarefas pendentes'),
          ),
          Expanded(
            child: visibleTasks.isEmpty
                ? Center(child: Text(_showCompleted ? 'Nenhuma tarefa concluída.' : 'Nenhuma tarefa pendente.'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 90),
                    itemCount: visibleTasks.length,
                    itemBuilder: (context, index) {
                      final task = visibleTasks[index];
                      return Card(
                        color: const Color(0xFFFFE66D),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(task.title, style: TextStyle(decoration: task.completed ? TextDecoration.lineThrough : null)),
                          subtitle: Text('Criada em ${_formatDate(task.createdAt)}', style: const TextStyle(fontSize: 12)),
                          trailing: Checkbox(value: task.completed, onChanged: (value) => _toggleTask(task, value)),
                        ),
                      );
                    },
                  ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'info_fab',
        tooltip: 'Sobre o aplicativo',
        onPressed: _showInfoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
