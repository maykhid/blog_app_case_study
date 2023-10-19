import 'package:blog_app_case_study/app/features/search/ui/cubit/search_cubit.dart';
import 'package:blog_app_case_study/app/features/search/ui/views/widget/posts_result_view.dart';
import 'package:blog_app_case_study/core/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsSearchDelegate extends SearchDelegate<String> {
  PostsSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here.
    return Text('Search suggestions: $query');
  }

  // @override
  // void showResults(
  //   BuildContext context, {
  //   bool shouldSaveSearchItem = true,
  // }) {
  //   if (query.isEmpty) {
  //     return;
  //   }

  //   cubit.search(query);
  //   super.showResults(context);
  // }

  @override
  String get searchFieldLabel => 'Search post title';

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here.
    return BlocProvider(
      create: (context) =>
          SearchCubit(searchPostsWithAuthorsUseCase: di())..search(query),
      child: const PostsResultView(),
    );
  }
}
