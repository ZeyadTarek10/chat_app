part of 'groups_cubit.dart';

@immutable
sealed class GroupsState {}

final class GroupsInitial extends GroupsState {}

final class GroupsLoading extends GroupsState {}
final class GroupsSuccess extends GroupsState {}
final class GroupsError extends GroupsState {
  final String error;
  GroupsError(this.error);
}
final class GroupsUpdated extends GroupsState {}

final class GroupsLoaded extends GroupsState {
  final List<GroupsEntity> groups;
  GroupsLoaded(this.groups);
}

final class GroupsUsersLoading extends GroupsState {}

final class GroupsSearchUpdatedState extends GroupsState {}