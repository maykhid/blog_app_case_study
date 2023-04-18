import 'package:blog_app_case_study/app/shared/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'core/dependency_injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, '.db.post');
  await Hive.initFlutter(dbPath);

  // register custom types
  Hive
    ..registerAdapter(PostsResponseAdapter())
    ..registerAdapter(PostAdapter())
    ..registerAdapter(AuthorAdapter())
    ..registerAdapter(AuthorsResponseAdapter());

  await setupLocator();

  runApp(const BlogApp());
}
