import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUseCase {
  final GroupsRepository groupsRepository;

  GetAllUsersUseCase({required this.groupsRepository});

  Future<Either<Failure, List<Map<String, dynamic>>>> call() async {
    return await groupsRepository.getAllUsers();
  }
}