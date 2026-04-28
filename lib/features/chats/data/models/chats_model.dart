import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';

class ChatsModel extends ChatsEntity {
  ChatsModel({
    required super.fact,
    required super.length,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
        fact: json["fact"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "length": length,
      };
}
