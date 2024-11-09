# riverpod_tutorial Insha Allah

A new Flutter project.

## Getting Started

# Use ref.Red marka aad donayso inaad value ga wax ka bedesho isticmaal ref.watch mrka value ga is bedelkisa la soconayso

__How initialise mutable variable in river pod__

```dart

final nameProvider = StateProvider<String>((ref) {
  return "Asc Mohamed";
});

```

__Marka aad donayso inaaad ogato is bedelka varibale__

```dart
ref.listen(nameProvider, (prev,next){
print("Value changed alxm... $next");
});
```

__If you want to initialize model and change it__

```dart

final userProvider = StateProvider<User>((ref) {
  return User("Mohamed", "Saeed", 25);
});

class User {
  final String firstName;
  final String lastName;
  final int age;

  User(this.firstName, this.lastName, this.age);

  User copyWith({String? firstName, String? lastName, int? age}) {
    return User(firstName ?? this.firstName, lastName ?? this.lastName,
        age ?? this.age);
  }
}

```

__change the value like this__

```dart


TextButton
(
onPressed: () {
ref
    .read(userProvider.notifier)
    .update((state) => state.copyWith(firstName: "Deeq"));
},
child: const Text("Change text"),
)
,

```

__syntax__

```dart



class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.firstName),
            Text(user.lastName),
            Text(user.age.toString()),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(userProvider.notifier)
                    .update((state) => state.copyWith(firstName: "Deeq"));
              },
              child: const Text("Change text"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
              },
              child: const Text("Go to splash"),
            )
          ],
        ),
      ),
    );
  }
}



```

# StateNotifierProvider

__Initialize like this__

```dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'name_provider.dart';

class UserProvider extends StateNotifier<User> {
  UserProvider() : super(User("Jamac", "Axmed", 30));

  void changeName(String name) {
    state.copyWith(firstName: name);
  }
}
```

__Put this to main method level__

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final userStateProvider = StateNotifierProvider<UserProvider, User>((ref) {
  return UserProvider();
});
```

__Then use like this__


```dart
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(userStateProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userProvider.firstName),
            Text(userProvider.lastName),
            Text(userProvider.age.toString()),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                ref.read(userStateProvider.notifier).changeName("Deeq");
              },
              child: const Text("Change text"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
              },
              child: const Text("Go to splash"),
            )
          ],
        ),
      ),
    );
  }
}
```

# Future provider

__The first time write normal http request class__

````dart

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

````

__After this call the function fetch todos using Future provider__

```dart

final todoProvider = FutureProvider<List<Todo>>((ref) async {
  return await TodoService.fetchTodos();
});
```
__Call this from ui part__

```dart

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

```
