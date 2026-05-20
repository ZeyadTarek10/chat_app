import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/core/usecases/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  final UploadImageUseCase featureUc;

  UploadImageCubit({required this.featureUc}) : super(UploadImageStateInitial());

  static UploadImageCubit get(context) => BlocProvider.of(context);

  void postImage() async {
    emit(UploadImageStateLoading());
    var response = await featureUc.call(NoParams());

    emit(response.fold((l) => UploadImageStateError(error: l.massage),
        (r) => UploadImageStateSuccess()));
  }
}
