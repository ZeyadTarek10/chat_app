import 'package:chat_app/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:chat_app/config/app/upload_image/domain/repositories/upload_image_repositories.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class UploadImageUseCase implements UseCase<UploadImageEntities, NoParams> {
  final UploadImageRepositories uploadImageRepositories;

  UploadImageUseCase({required this.uploadImageRepositories});

  @override
  Future<Either<Failure, UploadImageEntities>> call(NoParams params) {
    return uploadImageRepositories.postImage();
  }
}
