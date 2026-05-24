import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';

class GroupsModel extends GroupsEntity {
  GroupsModel({
    required super.id,
    required super.name,
    required super.members,
    required super.adminsId,
    required super.image,
    required super.createdAt,
    required super.lastMessage,
    required super.lastMessageTime, required super.memberNames, super.unreadCounts,
  });

  factory GroupsModel.fromJson(Map<String, dynamic> json) => GroupsModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      members: json["members"] != null ? List<String>.from(json["members"]) : [],
      memberNames: json["member_names"] != null ? List<String>.from(json["member_names"]) : [],
      adminsId: json["admin_ids"] != null ? List<String>.from(json["admin_ids"]) : [],
      image: json["image"] != null ? List<String>.from(json["image"]) : [],
      createdAt: json["created_at"] ?? "",
      lastMessage: json["last_message"] ?? "",
      lastMessageTime: json["last_message_time"] ?? "",
      unreadCounts: json["unread_counts"] != null
            ? Map<String, int>.from(json["unread_counts"] as Map)
            : {},
    );

  Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'members': members,
      'member_names': memberNames,
      'admin_ids': adminsId,
      'image': image,
      'created_at': createdAt,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'unread_counts': unreadCounts,
      };
}