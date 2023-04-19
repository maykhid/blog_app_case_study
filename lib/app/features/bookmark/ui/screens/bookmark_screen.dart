import 'package:blog_app_case_study/app/shared/models/authors_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../../../../../core/utils/enums.dart';

import '../../../home/ui/widgets/postcard_widget.dart';
import '../cubits/bookmarkedPosts/bookmarked_posts_cubit.dart';
import '../cubits/bookmarkedPosts/boookmarked_posts_state.dart';
import '../widgets/app_snackbar.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocProvider<BookmarkPostsCubit>(
          create: (ctx) => BookmarkPostsCubit(
              getPostsWithAuthorsUseCase: di(), bookmarkRepository: di())
            ..getBookmarkedPosts(),
          child: BlocConsumer<BookmarkPostsCubit, BookmarkPostsState>(
            listener: (context, state) {
              if (state.status == DataResponseStatus.error) {
                AppSnackBar.showErrorSnackBar(context, state.message!);
              }
            },
            builder: (context, state) {
              final bookmarkedPosts = state.bookmarkedPostsUsers != null
                  ? state.bookmarkedPostsUsers!.value1.posts
                  : [];

              final authors = state.bookmarkedPostsUsers != null
                  ? state.bookmarkedPostsUsers!.value2
                  : AuthorsResponse(users: []);

              switch (state.status) {
                // initial
                case DataResponseStatus.initial:

                // processing
                case DataResponseStatus.processing:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                // on error
                case DataResponseStatus.error:
                  return const Center(
                    child: Text(
                      'Could not load bookmarked posts!',
                    ),
                  );

                case DataResponseStatus.success:
                  if (bookmarkedPosts.isEmpty) {
                    return const Center(
                      child: Text(
                        'You do not have any bookmarked posts yet!',
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, count) => const SizedBox.square(
                      dimension: 8,
                    ),
                    itemCount: bookmarkedPosts.length,
                    itemBuilder: (context, index) => PostCard(
                      showBookmarkedStatus: true,
                      post: bookmarkedPosts[index],
                      authorsResponse: authors,
                      onBookmarkPressed: () => _handleRemoveBookmark(
                          context.read<BookmarkPostsCubit>(), index),
                    ),
                  );

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _handleRemoveBookmark(BookmarkPostsCubit cubit, int index) => cubit
    ..clearBookmarkedPost(index)
    ..getBookmarkedPosts();
}
