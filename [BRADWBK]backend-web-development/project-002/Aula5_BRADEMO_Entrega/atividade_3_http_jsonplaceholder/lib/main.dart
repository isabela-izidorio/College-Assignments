import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const JsonPlaceholderApp());

class JsonPlaceholderApp extends StatelessWidget {
  const JsonPlaceholderApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'JSONPlaceholder CRUD',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
        home: const PostsPage(),
      );
}

class Post {
  const Post({required this.userId, required this.id, required this.title, required this.body});
  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: (json['userId'] as num?)?.toInt() ?? 0,
        id: (json['id'] as num?)?.toInt() ?? 0,
        title: json['title']?.toString() ?? '(sem título)',
        body: json['body']?.toString() ?? '',
      );

  Map<String, dynamic> toJson({bool includeId = true}) => {
        'userId': userId,
        if (includeId) 'id': id,
        'title': title,
        'body': body,
      };
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  final _idController = TextEditingController(text: '1');
  final _userIdController = TextEditingController(text: '1');
  final _titleController = TextEditingController(text: 'Post criado pelo Flutter');
  final _bodyController = TextEditingController(text: 'Exemplo de requisição HTTP com JSONPlaceholder.');
  bool _loading = false;
  String _status = 'Escolha uma operação. A resposta será exibida aqui.';
  List<Post> _posts = [];
  Post? _selectedPost;

  int get _postId => int.tryParse(_idController.text.trim()) ?? 1;
  int get _userId => int.tryParse(_userIdController.text.trim()) ?? 1;

  Future<http.Response> _request(String method, Uri uri, {Map<String, dynamic>? jsonBody}) async {
    final headers = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};
    switch (method) {
      case 'GET': return http.get(uri, headers: headers).timeout(const Duration(seconds: 15));
      case 'POST': return http.post(uri, headers: headers, body: jsonEncode(jsonBody)).timeout(const Duration(seconds: 15));
      case 'PUT': return http.put(uri, headers: headers, body: jsonEncode(jsonBody)).timeout(const Duration(seconds: 15));
      case 'DELETE': return http.delete(uri, headers: headers).timeout(const Duration(seconds: 15));
      default: throw ArgumentError('Método HTTP não suportado: $method');
    }
  }

  Future<void> _run(String label, Future<void> Function() action) async {
    setState(() { _loading = true; _status = '$label em andamento...'; });
    try {
      await action();
    } catch (error) {
      if (mounted) setState(() => _status = 'Falha em $label: $error\nVerifique sua conexão e tente novamente.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _getOne() => _run('GET individual', () async {
        final response = await _request('GET', Uri.parse('$_baseUrl/posts/$_postId'));
        if (response.statusCode == 200) {
          final post = Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
          setState(() { _selectedPost = post; _status = 'GET /posts/$_postId — HTTP ${response.statusCode}\n${const JsonEncoder.withIndent('  ').convert(post.toJson())}'; });
        } else {
          setState(() => _status = 'GET individual — HTTP ${response.statusCode}\n${response.body}');
        }
      });

  Future<void> _getList() => _run('GET de lista', () async {
        final response = await _request('GET', Uri.parse('$_baseUrl/posts'));
        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body) as List<dynamic>;
          final posts = decoded.map((item) => Post.fromJson(item as Map<String, dynamic>)).toList();
          setState(() { _posts = posts; _status = 'GET /posts — HTTP ${response.statusCode}\n${posts.length} publicações recebidas. A lista está abaixo.'; });
        } else {
          setState(() => _status = 'GET lista — HTTP ${response.statusCode}\n${response.body}');
        }
      });

  Future<void> _post() => _run('POST', () async {
        final payload = Post(userId: _userId, id: 0, title: _titleController.text.trim(), body: _bodyController.text.trim()).toJson(includeId: false);
        final response = await _request('POST', Uri.parse('$_baseUrl/posts'), jsonBody: payload);
        setState(() => _status = 'POST /posts — HTTP ${response.statusCode}\n${_prettyBody(response.body)}\n\nJSONPlaceholder simula a criação; não persiste o recurso.');
      });

  Future<void> _put() => _run('PUT', () async {
        final payload = Post(userId: _userId, id: _postId, title: _titleController.text.trim(), body: _bodyController.text.trim()).toJson();
        final response = await _request('PUT', Uri.parse('$_baseUrl/posts/$_postId'), jsonBody: payload);
        setState(() => _status = 'PUT /posts/$_postId — HTTP ${response.statusCode}\n${_prettyBody(response.body)}\n\nJSONPlaceholder simula a atualização; não persiste a alteração.');
      });

  Future<void> _delete() => _run('DELETE', () async {
        final response = await _request('DELETE', Uri.parse('$_baseUrl/posts/$_postId'));
        setState(() { _status = 'DELETE /posts/$_postId — HTTP ${response.statusCode}\n${response.body.isEmpty ? '(corpo vazio)' : response.body}\n\nJSONPlaceholder simula a exclusão; não persiste a alteração.'; if (response.statusCode >= 200 && response.statusCode < 300) _selectedPost = null; });
      });

  String _prettyBody(String body) {
    try { return const JsonEncoder.withIndent('  ').convert(jsonDecode(body)); }
    catch (_) { return body; }
  }

  @override
  void dispose() {
    _idController.dispose(); _userIdController.dispose(); _titleController.dispose(); _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('JSONPlaceholder • HTTP CRUD')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          Text('Operações de rede', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          const Text('Exercite GET, GET de lista, POST, PUT e DELETE usando a API pública JSONPlaceholder.'),
          const SizedBox(height: 16),
          TextField(controller: _idController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ID do post (GET, PUT e DELETE)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.tag))),
          const SizedBox(height: 12),
          TextField(controller: _userIdController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ID do usuário (POST e PUT)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
          const SizedBox(height: 12),
          TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Título', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _bodyController, minLines: 2, maxLines: 4, decoration: const InputDecoration(labelText: 'Conteúdo', border: OutlineInputBorder(), alignLabelWithHint: true)),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: [
            FilledButton.icon(onPressed: _loading ? null : _getOne, icon: const Icon(Icons.search), label: const Text('GET post')),
            FilledButton.tonalIcon(onPressed: _loading ? null : _getList, icon: const Icon(Icons.list), label: const Text('GET lista')),
            FilledButton.icon(onPressed: _loading ? null : _post, icon: const Icon(Icons.add), label: const Text('POST')),
            FilledButton.tonalIcon(onPressed: _loading ? null : _put, icon: const Icon(Icons.edit), label: const Text('PUT')),
            OutlinedButton.icon(onPressed: _loading ? null : _delete, icon: const Icon(Icons.delete_outline), label: const Text('DELETE')),
          ]),
          if (_loading) const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: LinearProgressIndicator()),
          const SizedBox(height: 12),
          Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Status e resposta', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8), SelectableText(_status)]))),
          if (_selectedPost != null) ...[
            const SizedBox(height: 8),
            Text('Post individual selecionado', style: Theme.of(context).textTheme.titleLarge),
            _PostTile(post: _selectedPost!),
          ],
          if (_posts.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Lista de posts (${_posts.length})', style: Theme.of(context).textTheme.titleLarge),
            ..._posts.take(20).map((post) => _PostTile(post: post)),
            if (_posts.length > 20) Padding(padding: const EdgeInsets.all(8), child: Text('Exibindo os primeiros 20 de ${_posts.length} posts.')),
          ],
          const SizedBox(height: 12),
          const Text('Nota: a API de demonstração não persiste POST, PUT ou DELETE. O status e o corpo HTTP ajudam a conferir cada operação.'),
        ]),
      );
}

class _PostTile extends StatelessWidget {
  const _PostTile({required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('${post.id}')),
          title: Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(post.body, maxLines: 3, overflow: TextOverflow.ellipsis),
          isThreeLine: true,
        ),
      );
}
