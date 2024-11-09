import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/todo_provider.dart';
import 'package:riverpod_tutorial/services/services.api_service.dart';
import 'package:riverpod_tutorial/splash_screen.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
          // title: Text("Todos ${todos.}"),
          ),
      body: todos.when(
          data: (data) => todosWidget(data, context),
          error: (error, stackTrace) => errorWidget(error),
          loading: loading),
    );
  }

  ListView todosWidget(data, context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Todo todo = data.elementAt(index);
        return ListTile(
          leading: CircleAvatar(
            child: Text(todo.userId.toString()),
          ),
          title: Text(todo.title),
          trailing: Text(todo.completed == true ? "T" : "F"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SplashScreen(todo)));
          },
        );
      },
    );
  }

  Center errorWidget(error) {
    return Center(
      child: Text("An error occured ${error.toString()}"),
    );
  }

  Center loading() {
    return const Center(child: CircularProgressIndicator());
  }
}
