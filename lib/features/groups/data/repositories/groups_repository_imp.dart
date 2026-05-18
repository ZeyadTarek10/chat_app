import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/error/firebase_error_logger.dart';
import 'package:chat_app/features/groups/data/data_sources/groups_remote_data_source.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:dartz/dartz.dart';

class GroupsRepositoryImp implements GroupsRepository {
  final GroupsRemoteDataSource remoteDataSource;

  GroupsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createGroup(
      {required String groupName,
      required List<String> members,
      required List<String> memberNames,
      required List<String> image}) async {
    try {
      final group = await remoteDataSource.createGroup(
          groupName: groupName,
          members: members,
          memberNames: memberNames,
          image: image);
      return right(group);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }

  @override
Stream<Either<Failure, List<GroupsEntity>>> getGroups() {
  return remoteDataSource.getGroups().map<Either<Failure, List<GroupsEntity>>>(
    (groupsModelList) {
      return Right(groupsModelList); 
    },
  ).handleError((e) {
    printFirebaseError(e);
    return Left(ServerFailure(e.toString()));
  });
}

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllUsers() async {
    try {
      final users = await remoteDataSource.getAllUsers();
      return right(users);
    } catch (e, stackTrace) {
      printFirebaseError(e, stackTrace);
      return left(ServerFailure(e.toString()));
    }
  }
}
