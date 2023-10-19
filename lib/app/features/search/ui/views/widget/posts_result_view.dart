import 'package:blog_app_case_study/app/features/posts/ui/views/screen/post_view_screen.dart';
import 'package:blog_app_case_study/app/features/posts/ui/views/widgets/post_card.dart';
import 'package:blog_app_case_study/app/features/search/ui/cubit/search_cubit.dart';
import 'package:blog_app_case_study/core/di.dart';
import 'package:blog_app_case_study/core/router/navigation_service.dart';
import 'package:blog_app_case_study/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsResultView extends StatelessWidget {
  const PostsResultView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = di<NavigationService>();
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case DataResponseStatus.initial:
          case DataResponseStatus.processing:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case DataResponseStatus.error:
            return const Center(
              child: Text(
                '''              Could not pefrorm search!\nCheck internet connection and try again''',
              ),
            );

          case DataResponseStatus.success:
            final searchResults = state.postsAuthorsResponse?.posts;
            final authors = state.postsAuthorsResponse?.authors;
            
            if (searchResults!.isEmpty) {
              return const Center(
                child: Text(
                  'Not Found! Try another search term',
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                itemCount: searchResults.length,
                separatorBuilder: (context, index) => const SizedBox.square(
                  dimension: 8,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => navigationService.navigateToRoute(
                    PostView(
                      post: searchResults[index],
                      authors: authors,
                    ),
                  ),
                  child: PostCard(
                    post: searchResults[index],
                    authors: authors!,
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
