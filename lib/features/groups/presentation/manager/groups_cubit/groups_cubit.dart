import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/groups/domain/use_cases/create_groups_use_case.dart';
import 'package:chat_app/features/groups/domain/use_cases/get_all_users_use_case.dart';
import 'package:chat_app/features/groups/domain/use_cases/get_groups_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final CreateGroupsUseCase createGroupsUseCase;
  final GetGroupsUseCase getGroupsUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  GroupsCubit({required this.createGroupsUseCase, required this.getGroupsUseCase, required this.getAllUsersUseCase})
      : super(GroupsInitial());

  String groupName = "";
  List<Map<String, dynamic>> selectedMembers = [];
  List<Map<String, dynamic>> contacts = [];

  void updateName(String name) {
    groupName = name;
    emit(GroupsUpdated());
  }

  void toggleContact(int index, bool isSelected) {
    contacts[index]['selected'] = isSelected;
    emit(GroupsUpdated());
  }

  void confirmSelection() {
    selectedMembers =
        contacts.where((element) => element['selected'] == true).toList();
    emit(GroupsUpdated());
  }

  void removeMember(int index) {
    String idToRemove = selectedMembers[index]['id'];
    int contactIndex = contacts.indexWhere((e) => e['id'] == idToRemove);
    if (contactIndex != -1) contacts[contactIndex]['selected'] = false;

    selectedMembers.removeAt(index);
    emit(GroupsUpdated());
  }

String memberSearchQuery = '';

void updateMemberSearchQuery(String query) {
  memberSearchQuery = query.toLowerCase();
  emit(GroupsSearchUpdatedState()); 
}

List<Map<String, dynamic>> get filteredContacts {
  if (memberSearchQuery.isEmpty) {
    return contacts;
  }
  return contacts.where((contact) {
    final name = (contact['name'] ?? '').toString().toLowerCase();
    final phone = (contact['phone'] ?? '').toString().toLowerCase();
    
    return name.contains(memberSearchQuery) || phone.contains(memberSearchQuery);
  }).toList();
}

  Future<void> submitGroup() async {
    if (groupName.isEmpty) {
      emit(GroupsError("please_enter_the_group_name".tr()));
      return;
    }

    emit(GroupsLoading());
    List<String> memberIds = selectedMembers.map((e) => e['id'].toString()).toList();

    List<String> memberNames = selectedMembers.map((e) => e['name'].toString()).toList();

    List<String> memberimage = selectedMembers.map((e) => e['image'].toString()).toList();

    final result = await createGroupsUseCase.call(groupName, memberIds, memberNames, memberimage);

    result.fold((failure){
      emit(GroupsError(failure.massage)); 
    }, (_) async{
      groupName = "";
      selectedMembers.clear();
      for (var contact in contacts) { contact['selected'] = false; }
      emit(GroupsSuccess());
    });
  }

  void fetchGroups() {
  emit(GroupsLoading());
  getGroupsUseCase.call().listen((result) {
    result.fold(
      (failure) => emit(GroupsError(failure.massage)),
      (groupsList) => emit(GroupsLoaded(groupsList)),
    );
  }).onError((error) {
    emit(GroupsError(error.toString()));
  });
}

  Future<void> fetchAvailableUsers() async {
    if (contacts.isNotEmpty) return; 

    emit(GroupsUsersLoading());

    final result = await getAllUsersUseCase.call();

    result.fold((failure) {
      emit(GroupsError(failure.massage));
    }, (usersList) {
      contacts = usersList;
      emit(GroupsUpdated()); 
    });
  }
}
