class CommentEntity {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String userImage;
  final String commentText;
  final DateTime time;

  CommentEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.commentText,
    required this.time,
  });
}