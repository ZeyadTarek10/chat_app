import 'package:chat_app/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:chat_app/config/app/upload_image/domain/repositories/upload_image_repositories.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:share_plus/share_plus.dart';

class UploadImageUseCase implements UseCase<UploadImageEntities, XFile> {
  final UploadImageRepositories uploadImageRepositories;

  UploadImageUseCase({required this.uploadImageRepositories});

  @override
  Future<Either<Failure, UploadImageEntities>> call(XFile imageXFile) {
    return uploadImageRepositories.postImage(imageXFile);
  }
}
