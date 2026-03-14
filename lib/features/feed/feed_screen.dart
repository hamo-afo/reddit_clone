import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/error_text.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/core/common/post_card.dart';
import 'package:reddit_tutorial/features/community/repository/controller/community_controller.dart';
import 'package:reddit_tutorial/features/post/controller/post_controller.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userCommunitiesProvider).when(
          data: (communities) {
            if (kDebugMode)
              print(
                  '[FeedScreen] Communities fetched: ${communities.length} - ${communities.map((c) => c.name).toList()}');
            return ref.watch(userPostsProvider(communities)).when(
                  data: (data) {
                    if (kDebugMode)
                      print('[FeedScreen] Posts fetched: ${data.length}');
                    if (data.isEmpty && communities.isNotEmpty) {
                      if (kDebugMode)
                        print(
                            '[FeedScreen] WARNING: No posts found for communities: ${communities.map((c) => c.name).toList()}');
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final post = data[index];
                        return PostCard(post: post);
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    if (kDebugMode) {
                      print('[FeedScreen] ERROR fetching posts: $error');
                      print('[FeedScreen] StackTrace: $stackTrace');
                    }
                    return ErrorText(
                      error: error.toString(),
                    );
                  },
                  loading: () => const Loader(),
                );
          },
          error: (error, stackTrace) {
            if (kDebugMode) {
              print('[FeedScreen] ERROR fetching communities: $error');
              print('[FeedScreen] StackTrace: $stackTrace');
            }
            return ErrorText(
              error: error.toString(),
            );
          },
          loading: () => const Loader(),
        );
  }
}
