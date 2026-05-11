import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:dartz/dartz.dart';

class CreateGroupsUseCase {
  final GroupsRepository groupsRepository;

  CreateGroupsUseCase({required this.groupsRepository});

  Future<Either<Failure, void>> call(
    String groupName, List<String> members, List<String> memberNames, List<String> image) async {
    return await groupsRepository.createGroup(groupName: groupName, members: members, memberNames: memberNames, image: image);
  }
}





