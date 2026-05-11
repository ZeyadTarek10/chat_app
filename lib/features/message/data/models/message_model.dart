import 'package:chat_app/features/message/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.message,
    required super.id,
    required super.createdAt,
    required super.toId,
    required super.fromId,
    required super.type,
    required super.read,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        id: json['id'],
       createdAt: json['created_at'] is Timestamp 
          ? (json['created_at'] as Timestamp).toDate() 
          : DateTime.now(),
        toId: json['to_id'],
        fromId: json['from_id'],
        type: json['type'],
        read: json['read'],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "created_at": createdAt ?? DateTime.now(),
        "to_id": toId,
        "from_id": fromId,
        "type": type,
        "id": id,
        "read": read,
      };
}
