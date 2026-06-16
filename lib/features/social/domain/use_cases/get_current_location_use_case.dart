import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/social/domain/repositories/social_repositories.dart';
import 'package:dartz/dartz.dart';

class GetCurrentLocationUseCase {
  final SocialRepositories socialRepositories;
  const GetCurrentLocationUseCase({required this.socialRepositories});

  Future<Either<Failure, String>> call() async {
    return await socialRepositories.getCurrentLocation();
  }
}