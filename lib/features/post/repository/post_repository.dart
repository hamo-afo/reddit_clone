import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/core/constants/firebase_constants.dart';
import 'package:reddit_tutorial/core/failure.dart';
import 'package:reddit_tutorial/core/providers/firebase_providers.dart';
import 'package:reddit_tutorial/core/type_defs.dart';
import 'package:reddit_tutorial/model/community_model.dart';
import 'package:reddit_tutorial/model/post_model.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  FutureVoid addPost(Post post) async {
    try {
      if (kDebugMode)
        print(
            '[PostRepository] Saving post: id=${post.id}, community=${post.communityName}, type=${post.type}');
      await _posts.doc(post.id).set(post.toMap());
      if (kDebugMode) print('[PostRepository] Post saved successfully');
      return right(null);
    } on FirebaseException catch (e) {
      if (kDebugMode)
        print('[PostRepository] Firebase error saving post: ${e.message}');
      return left(Failure(e.message ?? 'Failed to add post'));
    } catch (e) {
      if (kDebugMode) print('[PostRepository] Error saving post: $e');
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> fetchUserPosts(List<Community> communities) {
    final communityNames = communities.map((e) => e.name).toList();
    if (kDebugMode)
      print('[PostRepository] Building query for communities: $communityNames');
    return _posts
        .where('communityName', whereIn: communityNames)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (event) {
        if (kDebugMode)
          print('[PostRepository] Query returned ${event.docs.length} posts');
        return event.docs.map(
          (e) {
            try {
              return Post.fromMap(
                e.data() as Map<String, dynamic>,
              );
            } catch (err) {
              if (kDebugMode)
                print('[PostRepository] Error parsing post: $err');
              rethrow;
            }
          },
        ).toList();
      },
    );
  }
}
