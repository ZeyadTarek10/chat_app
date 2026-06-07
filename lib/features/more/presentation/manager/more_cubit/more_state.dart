part of 'more_cubit.dart';

@immutable
sealed class MoreState {}

class MoreInitial extends MoreState {}
class LogoutLoading extends MoreState {}
class LogoutSuccess extends MoreState {}
class LogoutFailure extends MoreState {
  final String errorMessage;
  LogoutFailure(this.errorMessage);
}

final class CubitState extends MoreState {
  final bool isDark;
  CubitState.themeChangeMode({required this.isDark});
}