import 'package:blog_app_case_study/app/shared/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/models/posts_response.dart';
import 'package:dartz/dartz.dart';

typedef PostsWithAuthors = Tuple2<PostsResponse, AuthorsResponse>;