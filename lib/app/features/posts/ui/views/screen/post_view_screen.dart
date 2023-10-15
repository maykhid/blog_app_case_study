import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/app/shared/ui/extensions/sized_context.dart';
import 'package:blog_app_case_study/app/shared/ui/widgets/spacing.dart';
import 'package:blog_app_case_study/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({required this.post, required this.authors, super.key});

  final Post post;
  final List<Author> authors;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late Post post;
  late List<Author> authors;

  @override
  void initState() {
    post = widget.post;
    authors = widget.authors;
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
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const VerticalSpace(
              size: 20,
            ),

            SizedBox(
              // height: 50,
              width: context.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.width * 0.7,
                        // height: 60,
                        child: Wrap(
                          children: [
                            Text(
                              post.title,
                              // overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        authors[post.userId - 1].name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  //
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
                ],
              ),
            ),

            const VerticalSpace(
              size: 20,
            ),

            Expanded(
              child: Text(
                '''${post.body.capitalizeFirstLetter}. ${post.body.capitalizeFirstLetter}''',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
