import 'dart:convert';

import 'package:http/http.dart' as http;

class Todo {
  int userId;
  String title;
  bool completed;

  Todo(this.userId, this.title, this.completed);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['id'], json['title'], json['completed']);
  }

  Todo copyWith({int? userId, String? title, bool? completed}) {
    return Todo(userId ?? this.userId, title ?? this.title,
        completed ?? this.completed);
  }

  @override
  String toString() {
    return 'Todo{userId: $userId, title: $title, completed: $completed}';
  }
}

class TodoService {
  static Future<List<Todo>> fetchTodos() async {
    List<Todo> todos = [];
    final resource =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));

    if (resource.statusCode == 200) {
      List<dynamic> result = jsonDecode(resource.body);
      todos = result.map((todo) => Todo.fromJson(todo)).toList();
    }
    return todos;
  }
}
