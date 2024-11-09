import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/main.dart';
import 'package:riverpod_tutorial/providers/name_provider.dart';
import 'package:riverpod_tutorial/providers/user_provider.dart';
import 'package:riverpod_tutorial/splash_screen.dart';

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
