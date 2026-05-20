import 'package:chat_app/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UploadImageRepositories {
  Future<Either<Failure, UploadImageEntities>> postImage();
}
