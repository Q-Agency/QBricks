import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final int age;

  const User({
    required this.name,
    required this.age,
  });

  User copyWith({
    String? name,
    int? age,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  @override
  List<Object?> get props => [
        name,
        age,
      ];
}
