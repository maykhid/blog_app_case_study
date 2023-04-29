import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../../../../../core/router/navigation_service.dart';
import '../../../../../core/utils/enums.dart';

import '../../../../shared/data/models/authors_response.dart';
import '../../../home/ui/screens/postview_screen.dart';
import '../../../home/ui/widgets/postcard_widget.dart';
import '../cubits/search_cubit.dart';
import '../cubits/search_state.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      final searchResults = state.searchResponse != null
          ? state.searchResponse!.value1.posts
          : [];
      final authors = state.searchResponse != null
          ? state.searchResponse!.value2
          : AuthorsResponse(users: []);
      switch (state.status) {
        case DataResponseStatus.initial:
        case DataResponseStatus.processing:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case DataResponseStatus.error:
          return const Center(
              child: Text(
            '''              Could not pefrorm search!\nCheck internet connection and try again''', 
          ));

        case DataResponseStatus.success:
          if (searchResults.isEmpty) {
            return const Center(
              child: Text(
                'Not Found! Try another search term',
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: searchResults.length,
              separatorBuilder: (context, count) => const SizedBox.square(
                dimension: 8,
              ),
              itemBuilder: (context, count) => InkWell(
                onTap: () => navigationService.navigateToRoute(PostView(
                  post: searchResults[count],
                  authorsResponse: authors,
                )),
                child: PostCard(
                  post: searchResults[count],
                  authorsResponse: authors,
                ),
              ),
            ),
          );

        default:
          return Container();
      }
    });
  }
}
