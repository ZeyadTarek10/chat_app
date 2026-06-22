import 'package:chat_app/core/enum/story_type_enum.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.userId,
    required super.type,
    super.text,
    super.imageUrl,
    required super.backgroundColor,
    required super.createdAt,
    required super.viewers, 
    required super.likes,
  });


  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      userId: json['userId'],
      type: StoryType.values.byName(json['type']),
      text: json['text'],
      imageUrl: json['imageUrl'],
      backgroundColor: json['backgroundColor'] ?? 0xFF000000,
      createdAt: (json['createdAt'] as Timestamp).toDate(), 
      viewers: json['viewers'] != null ? List<String>.from(json['viewers']) : [], 
      likes: json['likes'] != null ? List<String>.from(json['likes']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.name,
      'text': text,
      'imageUrl': imageUrl,
      'backgroundColor': backgroundColor,
      'createdAt': FieldValue.serverTimestamp(),
      'viewers': viewers,
      'likes': likes,
    };
  }
}