class GroupsEntity {
  final String id;
  final String name;
  final List<String> image;
  final List<String> members;
  final List<String> memberNames;
  final List<String> adminsId;
  final String createdAt;
  final String lastMessage;
  final String lastMessageTime;
  final int? unreadCount;

  GroupsEntity({
    required this.id,
    required this.name,
    required this.members,
    required this.adminsId,
    required this.image,
    required this.createdAt,
    required this.lastMessage,
    required this.lastMessageTime, required this.memberNames, this.unreadCount,
  });
}