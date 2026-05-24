import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateProfilePictureUseCase {
  final ProfileRepositories profileRepositories;

  UpdateProfilePictureUseCase({required this.profileRepositories});

  Future<Either<Failure, void>> call({required String newImageUrl, required String uid}) {
    return profileRepositories.updateProfilePicture(newImageUrl: newImageUrl, uid: uid);
  }
}