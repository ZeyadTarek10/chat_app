import 'package:chat_app/features/first_feature/domain/entities/cat_fact_entity.dart';

class ChatsModel extends CatFactEntity {
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
