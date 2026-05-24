part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpFormUpdated extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpFailure extends SignUpState {
 final String errorMessage;

  SignUpFailure({required this.errorMessage});
}

final class GoogleSignInInitial extends SignUpState {}
final class GoogleSignInLoading extends SignUpState {}
final class GoogleSignInSuccess extends SignUpState {}
final class GoogleSignInFailure extends SignUpState {
  final String errorMessage;
  GoogleSignInFailure({required this.errorMessage});
}

