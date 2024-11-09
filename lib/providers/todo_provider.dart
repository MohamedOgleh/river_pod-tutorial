import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/services/services.api_service.dart';

// final todoProvider = FutureProvider<TodoService>((ref) {
//   return TodoService();
// });
//
//


final todoProvider = FutureProvider<List<Todo>>((ref) async {
  return await TodoService.fetchTodos();
});