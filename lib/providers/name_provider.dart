import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<String>((ref) {
  return "Asc Mohamed";
});

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
