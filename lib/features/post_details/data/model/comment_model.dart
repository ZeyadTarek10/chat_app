import 'package:chat_app/features/post_details/domain/entities/comment_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.postId,
    required super.userId,
    required super.userName,
    required super.userImage,
    required super.commentText,
    required super.time,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'],
        postId: json['post_id'],
        userId: json['user_id'],
        userName: json['user_name'],
        userImage: json['user_image'] ?? '',
        commentText: json['comment_text'],
        time: json['time'] is Timestamp 
            ? (json['time'] as Timestamp).toDate() 
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'post_id': postId,
        'user_id': userId,
        'user_name': userName,
        'user_image': userImage,
        'comment_text': commentText,
        'time': time,
      };
}