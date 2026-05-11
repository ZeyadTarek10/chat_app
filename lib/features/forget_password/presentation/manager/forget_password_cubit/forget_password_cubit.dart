import 'package:bloc/bloc.dart';
import 'package:chat_app/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:flutter/material.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgotPasswordUseCase;
  ForgetPasswordCubit({required this.forgotPasswordUseCase}) : super(ForgetPasswordInitial());

  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> resetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    var result = await forgotPasswordUseCase.call(email: emailController.text.trim());
    
    result.fold(
      (failure) => emit(ForgetPasswordFailure(errorMessage: failure.massage)),
      (success) => emit(ForgetPasswordSuccess()),
    );
  }
}
