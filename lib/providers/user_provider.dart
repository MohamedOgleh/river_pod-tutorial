import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'name_provider.dart';

class UserProvider extends StateNotifier<User> {
  UserProvider() : super(User("Jamac", "Axmed", 30));

  void changeName(String name) {
    state=state.copyWith(firstName: name);
  }
}
