import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/social/data/models/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StoryRemoteDataSource {
  Future<void> uploadStory(StoryModel story);
  Future<void> deleteStory(String storyId);
  Future<List<StoryModel>> fetchStories();
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> uploadStory(StoryModel story) async {
    try {
      await firestore.collection('stories').doc(story.id).set(story.toJson());
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }

  @override
  Future<void> deleteStory(String storyId) async {
    try {
      await firestore.collection('stories').doc(storyId).delete();
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
    }
  }

  @override
  Future<List<StoryModel>> fetchStories() async {
    final yesterday = DateTime.now().subtract(const Duration(hours: 24));

    final snapshot = await firestore
        .collection('stories')
        .where('createdAt', isGreaterThan: Timestamp.fromDate(yesterday))
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs.map((doc) => StoryModel.fromJson(doc.data())).toList();
  }
}
