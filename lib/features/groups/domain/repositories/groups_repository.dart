import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GroupsRepository {
  Future<Either<Failure, void>> createGroup(
      {required String groupName,
      required List<String> members,
      required List<String> memberNames,
      required List<String> image});
  Stream<Either<Failure,List<GroupsEntity>>> getGroups();
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllUsers();
  Future<Either<Failure, void>> resetGroupUnreadCount(String groupId);
}
