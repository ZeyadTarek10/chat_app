import 'package:chat_app/features/chats/domain/entities/chats_entity.dart';
import 'package:chat_app/features/chats/domain/use_cases/chats_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/usecases/usecase.dart';


part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  final ChatsUseCase chatsUseCase;

  ChatsCubit({required this.chatsUseCase}) : super(ChatsInitial());

  static ChatsCubit get(context) => BlocProvider.of(context);

  void getCatFact() async {
    emit(ChatsLoadingState());
    var response = await chatsUseCase.call(NoParams());

    emit(response.fold((l) => ChatsErrorState(errMsg: l.massage),
        (r) => ChatsSuccessState(chatsEntity: r)));
  }
}
