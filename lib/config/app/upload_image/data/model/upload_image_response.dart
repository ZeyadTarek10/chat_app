import 'package:chat_app/config/app/upload_image/domain/entities/upload_image_entities.dart';

class UploadImageModel extends UploadImageEntities {
  UploadImageModel({
    required super.body,
    required super.photo,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) => UploadImageModel(
        body: json['body'],
        photo: json['photo']
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "photo": photo,
      };
}
