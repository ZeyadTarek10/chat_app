import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:dartz/dartz.dart';

class GetGroupsUseCase {
  final GroupsRepository groupsRepository;
  GetGroupsUseCase({required this.groupsRepository});

  Stream<Either<Failure,List<GroupsEntity>>> call(){
    return groupsRepository.getGroups();
  }
  
}