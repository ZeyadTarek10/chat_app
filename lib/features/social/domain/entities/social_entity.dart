class SocialEntity {
  final String id;
  final String userId;
  final String userName;
  final String? userImage;
  final String postText;
  final String? postImage;
  final String? location;
  final DateTime? time;
  final int? likesCount;
  final int? commentsCount;
  final List<String> likedBy;

  SocialEntity(
      {required this.id,
      required this.userId,
      required this.userName,
      this.userImage,
      required this.postText,
      this.postImage,
      this.location,
      this.time,
      this.likesCount = 0,
      this.commentsCount = 0,
      this.likedBy = const [],
      });
}

