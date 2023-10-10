import 'package:blog_app_case_study/app/features/posts/ui/cubit/blog_post_cubit.dart';
import 'package:blog_app_case_study/app/features/posts/ui/views/screen/post_view_screen.dart';
import 'package:blog_app_case_study/app/features/posts/ui/views/widgets/post_card.dart';
import 'package:blog_app_case_study/core/di.dart';
import 'package:blog_app_case_study/core/router/navigation_service.dart';
import 'package:blog_app_case_study/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(
              //   context: context,
              //   delegate: CustomSearchDelegate(),
              // );
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocProvider<BlogPostsCubit>(
          create: (ctx) =>
              BlogPostsCubit(getPostsWithAuthorsUseCase: di())..getPostsAuthors(),
          child:
              BlocConsumer<BlogPostsCubit, BlogPostsState>(listener: (context, state) {
            if (state.status == DataResponseStatus.error) {
              // AppSnackBar.showErrorSnackBar(context, state.message!);
            }
          }, builder: (context, state) {
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
                return  Center(
                    child: Text(
                  state.message!,
                ));

              // on success
              case DataResponseStatus.success:
                final postResponse = state.postsAuthorsResponse!.posts;
                final authorsResponse = state.postsAuthorsResponse!.authors;
                return ListView.separated(
                  itemCount: postResponse!.length,
                  separatorBuilder: (context, count) => const SizedBox.square(
                    dimension: 8,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => navigationService.navigateToRoute(PostView(
                      post: postResponse[index],
                      authors: authorsResponse,
                    )),
                    child: PostCard(
                      authors: authorsResponse!,
                      post: postResponse[index],
                    ),
                  ),
                );

              default:
                return Container();
            }
          }),
        ),
      ),
    );
  }
}