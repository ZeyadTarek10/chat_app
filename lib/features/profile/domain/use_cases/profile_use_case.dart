import 'package:chat_app/features/profile/domain/repositories/profile_repositories.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';

class GetProfileUseCase implements UseCase<UserEntity, NoParams> {
  final ProfileRepositories profileRepositories;
  GetProfileUseCase({required this.profileRepositories});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return profileRepositories.getUser();
  }
}

class UpdateProfileUseCase implements UseCase<void, UserEntity> {
  final ProfileRepositories profileRepositories;
  UpdateProfileUseCase({required this.profileRepositories});

  @override
  Future<Either<Failure, void>> call(UserEntity params) {
    return profileRepositories.updateUserProfile(params);
  }
}

class LogoutUseCase implements UseCase<void, NoParams> {
  final ProfileRepositories profileRepositories;
  LogoutUseCase({required this.profileRepositories});

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return profileRepositories.logout();
  }
}