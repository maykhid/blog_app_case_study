import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'posts_response.g.dart';

/// Posts class with List<Post> param
///
@HiveType(typeId: 0)
class PostsResponse extends Equatable {
  const PostsResponse({required this.posts});

  factory PostsResponse.fromJson(List<dynamic> data) => PostsResponse(
        posts: List<Post>.from(
          data.map((e) => Post.fromJson(e as Map<String, dynamic>)),
        ),
      );
  @HiveField(0)
  final List<Post> posts;

  @override
  String toString() => posts.toString();

  @override
  List<Object?> get props => [posts];
}

/// Post class
@HiveType(typeId: 1)
class Post extends Equatable {
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String body;

  Map<String, dynamic> toMap() =>
      {'userId': userId, 'id': id, 'title': title, 'body': body};

  @override
  String toString() => toMap().toString();

  @override
  List<Object?> get props => [userId, id, body, title];
}
