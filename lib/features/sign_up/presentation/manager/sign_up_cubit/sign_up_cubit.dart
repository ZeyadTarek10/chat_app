import 'package:bloc/bloc.dart';
import 'package:chat_app/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpCubit({required this.signUpUseCase}) : super(SignUpInitial());

  bool isPasswordVisible = false;
  bool isTermsAccepted = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignUpFormUpdated()); 
  }

  void toggleTermsAcceptance(bool? value) {
    isTermsAccepted = value ?? false;
    emit(SignUpFormUpdated()); 
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    if (!isTermsAccepted) {
      emit(SignUpFailure(errorMessage: 'please_accept_the_terms_of_use'.tr()));
      return;
    }

    emit(SignUpLoading());

    var result = await signUpUseCase.call(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    result.fold(
      (failure) {
        emit(SignUpFailure(errorMessage: failure.massage));
      },
      (success) {
        emit(SignUpSuccess());
      },
    );
  }
}