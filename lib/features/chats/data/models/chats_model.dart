import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsModel extends ChatsEntity {
  ChatsModel({
    required super.id,
    required super.members,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.createdAt,
    super.friendName,   
    super.friendImage,
    super.unreadCount,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
        id: json["id"] ?? "",
        members: json["members"] ?? [],
        lastMessage: json["last_message"] ?? "",
        lastMessageTime: json["last_message_time"] is Timestamp 
        ? (json["last_message_time"] as Timestamp).toDate() 
        : null,
        createdAt: json["created_at"] is Timestamp 
        ? (json["created_at"] as Timestamp).toDate() 
        : DateTime.now(),
        friendName: json["friend_name"] ?? "Unknown", 
        friendImage: json["friend_image"] ?? "",
        unreadCount: json["unread_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "members": members,
        "last_message": lastMessage,
        "last_message_time": lastMessageTime,
        "created_at": createdAt,
      };
}
