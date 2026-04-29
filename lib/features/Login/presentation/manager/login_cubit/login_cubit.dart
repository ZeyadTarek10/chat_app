import 'package:chat_app/features/Login/domain/use_cases/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  bool isPasswordVisible = false;
  bool isKeepMeSignedIn = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginFormUpdated()); 
  }

  void toggleKeepMeSignedIn(bool? value) {
    isKeepMeSignedIn = value ?? false;
    emit(LoginFormUpdated()); 
  }


  Future<void> signInUser({
    required String email, 
    required String password, 
    required bool isKeepMeSignedIn
  }) async {
    emit(LoginLoading());
    
    var result = await loginUseCase.call(
      email: emailController.text, 
      password: passwordController.text, 
      isKeepMeSignedIn: isKeepMeSignedIn
    );
    
    result.fold(
      (failure) {
        emit(LoginFailure(errorMessage: failure.massage)); 
      },
      (success) {
        emit(LoginSuccess());
      }
    );
  }
}