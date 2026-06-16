import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SocialModel extends SocialEntity {
  SocialModel({
    required super.id,
    required super.userId,
    required super.userName,
    super.userImage,
    required super.postText,
    super.postImage,
    super.time,
    super.commentsCount,
    super.likesCount,
    super.location,
    super.likedBy = const [],
  });

  SocialModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userImage,
    String? postText,
    String? postImage,
    DateTime? time,
    int? commentsCount,
    int? likesCount,
    String? location,
    List<String>? likedBy,
  }) {
    return SocialModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      postText: postText ?? this.postText,
      postImage: postImage ?? this.postImage,
      time: time ?? this.time,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
      location: location ?? this.location,
      likedBy: likedBy ?? this.likedBy,
    );
  }
  
  factory SocialModel.fromJson(Map<String, dynamic> json) => SocialModel(
        id: json['id'],
        userId: json['user_id'],
        userName: json['user_name'],
        userImage: json['user_image'] ?? '',
        postText: json['post_text'],
        postImage: json['post_image'] ?? '',
        time: json['time'] is Timestamp
            ? (json['time'] as Timestamp).toDate()
            : DateTime.now(),
        commentsCount: json['comments_count'] ?? 0,
        likesCount: json['likes_count'] ?? 0,
        likedBy: List<String>.from(json['liked_by'] ?? []),
        location: json['location'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "user_id": userId,
        'user_name': userName,
        'user_image': userImage,
        'post_text': postText,
        'post_image': postImage,
        'time': time ?? DateTime.now(),
        'comments_count': commentsCount,
        'likes_count': likesCount,
        'liked_by': likedBy,
        'location': location,
      };
}
