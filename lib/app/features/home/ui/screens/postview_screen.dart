import 'package:blog_app_case_study/app/shared/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/ui/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../../../../shared/ui/widgets/app_spacing.dart';
import '../../../../shared/models/posts_response.dart';
import '../../../bookmark/ui/cubits/bookmarkedPosts/bookmarked_posts_cubit.dart';
import '../../../bookmark/ui/cubits/bookmarkedPosts/boookmarked_posts_state.dart';

class PostView extends StatefulWidget {
  const PostView(
      {super.key, required this.post, required this.authorsResponse});

  final Post post;
  final AuthorsResponse authorsResponse;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late Post post;
  late AuthorsResponse authorsResponse;

  @override
  void initState() {
    post = widget.post;
    authorsResponse = widget.authorsResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: context.width * 0.3,
          child: Text(
            post.title,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // post image
            Container(
              height: 210,
              width: context.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/dummy.jpg',
                      ),
                      fit: BoxFit.cover)),
            ),

            const VerticalSpace(
              size: 20,
            ),

            BlocProvider<BookmarkPostsCubit>(
              create: (ctx) => BookmarkPostsCubit(
                getPostsWithAuthorsUseCase: di(),
                bookmarkRepository: di(),
              )..getBookmarkedPosts(),
              child: BlocConsumer<BookmarkPostsCubit, BookmarkPostsState>(
                  listener: (context, state) {
                // listen and call when needed
              }, builder: (context, state) {
                List<Post> bookmarkedPosts = state.bookmarkedPostsUsers != null
                    ? state.bookmarkedPostsUsers!.value1.posts
                    : [];
                return SizedBox(
                  height: 50,
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.width * 0.60,
                            // height: 60,
                            child: Text(
                              post.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            authorsResponse.users[post.userId - 1].name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      //
                      SizedBox(
                        // width: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              // onPressed: () => SocialShare.shareOptions(
                              //     'Read this blog post by: ${users.users[post.userId - 1].name}\n\n ${post.body} \n\n https://blogpost.inapp.url'),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                                color: Colors.teal,
                                size: 30,
                              ),
                            ),
                            const HorizontalSpace(
                              size: 25,
                            ),

                            // bookmark button
                            IconButton(
                              onPressed: () =>
                                  _isPostBookmarked(bookmarkedPosts)
                                      ? _handleRemoveBookmark(
                                          context.read<BookmarkPostsCubit>(),
                                          bookmarkedPosts)
                                      : _handleBookmark(
                                          context.read<BookmarkPostsCubit>()),
                              icon: Icon(
                                Icons.bookmark,
                                size: 30,
                                color: _isPostBookmarked(bookmarkedPosts)
                                    ? Colors.teal
                                    : Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const VerticalSpace(
              size: 20,
            ),

            Expanded(
              child: Text(
                '${post.body} ${post.body}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isPostBookmarked(posts) => posts.contains(post);

  void _handleBookmark(BookmarkPostsCubit bookmarkCubit) => bookmarkCubit
    ..bookmarkPost(post)
    ..getBookmarkedPosts();

  _handleRemoveBookmark(BookmarkPostsCubit cubit, List<Post> posts) {
    int index = posts.indexWhere((p) => p == post);
    cubit
      ..clearBookmarkedPost(index)
      ..getBookmarkedPosts();
  }
}
