import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'authors_response.g.dart';

@HiveType(typeId: 2)
class Author extends Equatable {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final String name;

  const Author({required this.name, required this.userId});

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(userId: json["id"], name: json["name"]);

  @override
  List<Object?> get props => [userId, name];
}

@HiveType(typeId: 4)
class AuthorsResponse {
  @HiveField(0)
  List<Author> users;

  AuthorsResponse({required this.users});

  factory AuthorsResponse.fromJson(List<dynamic> data) => AuthorsResponse(
      users: List<Author>.from(data.map((e) => Author.fromJson(e))));

  @override
  String toString() => users.toString();
}
