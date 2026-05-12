import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class SearchUsersUseCase implements UseCase<List<UserEntity>, String >{
  final ChatsRepositories repository;

  SearchUsersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(String phone) async {
    return await repository.searchUserByPhone(phone: phone);
  }
}