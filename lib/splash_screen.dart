import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/name_provider.dart';
import 'package:riverpod_tutorial/services/services.api_service.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Splash screeen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Consumer(
            //   builder: (context, ref, child) {
            //     return Text(ref.watch(nameProvider));
            //   },
            // ),
            Text(todo.userId.toString()),

            Text(todo.title),
            Text(todo.completed.toString()),
            // Text(todo.title),

            TextButton(
                onPressed: () {
                  ref.invalidate(nameProvider);
                },
                child: Text("Change the name"))
          ],
        ),
      ),
    );
  }
}
