import 'package:chat_app/features/chats/domain/use_cases/create_chats_use_case.dart';
import 'package:chat_app/features/chats/domain/use_cases/search_chats_use_case.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_chats_state.dart';

class CreateChatsCubit extends Cubit<CreateChatsState> {
  final CreateChatsUseCase createChatsUseCase;
  final SearchUsersUseCase searchUsersUseCase;

  final TextEditingController phoneController = TextEditingController();

  final ValueNotifier<String> selectedCountryCode =
      ValueNotifier<String>('+20');

  CreateChatsCubit({
    required this.createChatsUseCase,
    required this.searchUsersUseCase,
  }) : super(CreateChatsInitial());

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  Future<void> searchUsers(String phone) async {
    if (phone.isEmpty) {
      emit(CreateChatsInitial());
      return;
    }

    emit(UsersSearchingState());

    final fullPhoneForSearch = phone.trim();

    final result = await searchUsersUseCase.call(fullPhoneForSearch);

    result.fold(
      (failure) {
        emit(CreateChatsErrorState(errMsg: failure.massage));
      },
      (usersList) {
        emit(UsersSearchSuccessState(foundUsers: usersList));
      },
    );
  }

  Future<void> createChat(String phone) async {
    emit(CreateChatsLoadingState());

    final fullPhone = phone.trim();

    final result = await createChatsUseCase.call(fullPhone);

    result.fold((failure) {
      emit(CreateChatsErrorState(errMsg: failure.massage));
    }, (chatRoomData) {
      emit(CreateChatsSuccessState(chatsEntity: chatRoomData));
    });
  }

}
