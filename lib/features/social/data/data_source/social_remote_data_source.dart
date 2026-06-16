import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/core/services/location_service.dart';
import 'package:chat_app/features/social/data/models/social_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class SocialRemoteDataSource {
  Future<void> addPost(SocialModel post);
  Stream<List<SocialModel>> getPosts();
  Future<void> updatePost(SocialModel post);
  Future<void> deletePost(String postId);
  Future<void> likePost(String postId, String userId, bool isLiked);
  Future<String> getCurrentLocation();
}

class SocialRemoteDataSourceImpl implements SocialRemoteDataSource {
  final LocationService locationService;

  SocialRemoteDataSourceImpl({required this.locationService});

  @override
  Future<void> addPost(SocialModel post) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .set(post.toJson());
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }

  @override
  Stream<List<SocialModel>> getPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => SocialModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }

  @override
  Future<String> getCurrentLocation() async {
    final locationData = await locationService.getCurrentLocation();

    if (locationData != null && locationData.containsKey('address')) {
      return locationData['address'] ?? "unknown_location".tr();
    }

    return "unknown_location".tr();
  }

  @override
  Future<void> likePost(String postId, String userId, bool isLiked) async {
    final docRef = FirebaseFirestore.instance.collection('posts').doc(postId);

    try {
      if (isLiked) {
        await docRef.update({
          'liked_by': FieldValue.arrayRemove([userId]),
          'likes_count': FieldValue.increment(-1),
        });
      } else {
        await docRef.update({
          'liked_by': FieldValue.arrayUnion([userId]),
          'likes_count': FieldValue.increment(1),
        });
      }
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }

  @override
  Future<void> updatePost(SocialModel post) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .update(post.toJson());
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }
}
