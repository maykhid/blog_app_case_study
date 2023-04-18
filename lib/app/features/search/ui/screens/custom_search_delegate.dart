
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../cubits/search_cubit.dart';
import '../widgets/search_result_view.dart';


class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();

  var cubit = di<SearchCubit>();

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
  Widget buildResults(BuildContext context) {
    // Implement your search results here.
    return BlocProvider.value(
      value: cubit,
      child: const SearchResultsView(),
    );
  }

  @override
  void showResults(
    BuildContext context, {
    bool shouldSaveSearchItem = true,
  }) {
    if (query.isEmpty) {
      return;
    }

    cubit.search(query);
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here.
    return Text('Search suggestions: $query');
  }

  @override
  String get searchFieldLabel => 'Search posts';
}
