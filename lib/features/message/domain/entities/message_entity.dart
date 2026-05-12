class MessageEntity {
  String? message;
  String? id;
  DateTime? createdAt;
  String? toId;
  String? fromId;
  String? type;
  String? read;

  MessageEntity({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.toId,
    required this.fromId,
    required this.type,
    required this.read,
  });
}
