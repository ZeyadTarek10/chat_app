class MessageEntity {
  String? message;
  String? id;
  DateTime? createdAt;
  String? toId;
  String? fromId;
  String? type;
  String? read;
  MessageEntity? replyMessage;

  MessageEntity({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.toId,
    required this.fromId,
    required this.type,
    required this.read,
    required this.replyMessage,
  });

  MessageEntity copyWith({String? message}) {
    return MessageEntity(
      id: id,
      message: message ?? this.message,
      createdAt: createdAt,
      toId: toId,
      fromId: fromId,
      type: type,
      read: read,
      replyMessage: replyMessage,
    );
  }

}
