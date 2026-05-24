import 'package:chat_app/core/usecases/usecase.dart';
import 'package:chat_app/features/profile/domain/use_cases/profile_use_case.dart';
import 'package:chat_app/features/profile/domain/use_cases/update_profile_picture_use_case.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final UpdateProfilePictureUseCase updateProfilePictureUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.logoutUseCase, required this.updateProfilePictureUseCase,
  }) : super(ProfileInitial());

  UserEntity? currentUser; 

  Future<void> getUserData() async {
    emit(ProfileLoading());
    final result = await getProfileUseCase(NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.massage)),
      (user) {
        currentUser = user;
        emit(ProfileLoaded(user));
      },
    );
  }

Future<void> updateProfilePicture(String newImageUrl) async {
  emit(ProfileLoading());

  final result = await updateProfilePictureUseCase.call(
    newImageUrl: newImageUrl,
    uid: currentUser!.uid, 
  );

  result.fold(
    (failure) {
      if (!isClosed) emit(ProfileError(failure.massage));
    },
    (_) {
      currentUser = currentUser!.copyWith(profilePicUrl: newImageUrl);
      
      if (!isClosed) emit(ProfileUpdateSuccess());
    },
  );
}

  Future<void> updateUserData(UserEntity updatedUser) async {
    emit(ProfileUpdateLoading());
    final result = await updateProfileUseCase(updatedUser);
    result.fold(
      (failure) => emit(ProfileUpdateError(failure.massage)),
      (_) {
        currentUser = updatedUser; 
        emit(ProfileUpdateSuccess());
        emit(ProfileLoaded(updatedUser)); 
      },
    );
  }

  Future<void> logout() async {
    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.massage)),
      (_) => emit(LogoutSuccess()),
    );
  }
}