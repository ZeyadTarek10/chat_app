import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/post_details/data/model/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CommentsRemoteDataSource {
  Stream<List<CommentModel>> getComments(String postId);
  Future<void> addComment(CommentModel comment);
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  @override
  Stream<List<CommentModel>> getComments(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('time', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> addComment(CommentModel comment) async {
    try {
      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(comment.postId);
      final commentRef = postRef.collection('comments').doc(comment.id);

      final batch = FirebaseFirestore.instance.batch();

      batch.set(commentRef, comment.toJson());
      batch.update(postRef, {'comments_count': FieldValue.increment(1)});

      await batch.commit();
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      throw Exception(e.toString());
    }
  }
}
