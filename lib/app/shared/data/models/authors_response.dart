import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'authors_response.g.dart';

@HiveType(typeId: 2)
class Author extends Equatable {
  const Author({required this.name, required this.userId});

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(userId: json['id'] as int, name: json['name'] as String);

  @HiveField(0)
  final int userId;
  @HiveField(1)
  final String name;

  @override
  List<Object?> get props => [userId, name];
}

@HiveType(typeId: 4)
class AuthorsResponse extends Equatable {
  const AuthorsResponse({required this.users});

  factory AuthorsResponse.fromJson(List<dynamic> data) => AuthorsResponse(
        users: List<Author>.from(
          data.map((e) => Author.fromJson(e as Map<String, dynamic>)),
        ),
      );

  @HiveField(0)
  final List<Author> users;

  @override
  String toString() => users.toString();

  @override
  List<Object?> get props => [users];
}
