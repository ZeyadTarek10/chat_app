part of 'social_cubit.dart';

@immutable
sealed class SocialState {}

final class SocialInitial extends SocialState {}

final class SocialLoading extends SocialState {}

final class SocialLoaded extends SocialState {
  final List<SocialEntity> posts;
  SocialLoaded(this.posts);
}
final class SocialError extends SocialState {
  final String message;
  SocialError(this.message);
}
final class SocialActionSuccess extends SocialState {} 

final class SocialLocationLoading extends SocialState {}

final class SocialLocationFetched extends SocialState {}

final class SocialImageUploading extends SocialState {}

final class SocialImageUploaded extends SocialState {}