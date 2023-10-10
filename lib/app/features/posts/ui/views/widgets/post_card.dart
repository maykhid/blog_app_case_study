

import 'package:blog_app_case_study/app/shared/data/models/authors_response.dart';
import 'package:blog_app_case_study/app/shared/data/models/posts_response.dart';
import 'package:blog_app_case_study/app/shared/ui/extensions/sized_context.dart';
import 'package:blog_app_case_study/app/shared/ui/widgets/spacing.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    this.showBookmarkedStatus = false,
    required this.post,
    required this.authors,
    this.onBookmarkPressed,
  });

  final bool showBookmarkedStatus;
  final Post post;
  final List<Author> authors;
  final VoidCallback? onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: context.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // pic view
              Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/dummy.jpg',
                        ),
                        fit: BoxFit.cover)),
              ),

              const HorizontalSpace(
                size: 10,
              ),

              // column with title, author
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.width * 0.40,
                    height: 30,
                    child: Text(
                      post.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const VerticalSpace(
                    size: 5,
                  ),
                  Text(authors[post.userId - 1].name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),

              const Spacer(),

              showBookmarkedStatus
                  ? IconButton(
                      onPressed: onBookmarkPressed ?? () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.teal,
                      ))
                  : const SizedBox(),
            ],
          ),

          const VerticalSpace(
            size: 10,
          ),

          // short blog details text
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.body,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}