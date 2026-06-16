import 'package:chat_app/core/enum/story_type_enum.dart';

class StoryEntity {
  final String id;
  final String userId;
  final StoryType type;
  final String? text;
  final String? imageUrl;
  final int backgroundColor;
  final DateTime createdAt;
  final List<String> viewers;
  final List<String> likes;

  const StoryEntity({
    required this.id,
    required this.userId,
    required this.type,
    this.text,
    this.imageUrl,
    this.backgroundColor = 0xFF000000,
    required this.createdAt,
    this.viewers = const [], 
    this.likes = const [],
  });
  
  StoryEntity copyWith({
    String? id,
    String? userId,
    StoryType? type,
    String? text,
    String? imageUrl,
    int? backgroundColor,
    DateTime? createdAt,
    List<String>? viewers,
    List<String>? likes,
  }) {
    return StoryEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      createdAt: createdAt ?? this.createdAt,
      viewers: viewers ?? this.viewers,
      likes: likes ?? this.likes,
    );
  }
}
