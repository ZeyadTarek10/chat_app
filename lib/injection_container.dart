import 'package:chat_app/config/app/cubit/app_cubit.dart';
import 'package:chat_app/config/app/upload_image/data/data_source/upload_image_remote_data_source.dart';
import 'package:chat_app/config/app/upload_image/data/repositories/upload_image_repositories_impl.dart';
import 'package:chat_app/config/app/upload_image/domain/repositories/upload_image_repositories.dart';
import 'package:chat_app/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:chat_app/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:chat_app/features/Login/data/data_sources/login_remote_data_source.dart';
import 'package:chat_app/features/Login/data/repositories/login_repository_impl.dart';
import 'package:chat_app/features/Login/domain/repositories/login_repository.dart';
import 'package:chat_app/features/Login/domain/use_cases/login_use_case.dart';
import 'package:chat_app/features/Login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:chat_app/features/chats/data/data_sources/create_chats_remote_data_source.dart';
import 'package:chat_app/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:chat_app/features/chats/domain/repositories/chats_repositories.dart';
import 'package:chat_app/features/chats/domain/use_cases/create_chats_use_case.dart';
import 'package:chat_app/features/chats/domain/use_cases/get_chat_use_case.dart';
import 'package:chat_app/features/chats/domain/use_cases/search_chats_use_case.dart';
import 'package:chat_app/features/chats/presentation/manager/create_chats_cubit/create_chats_cubit.dart';
import 'package:chat_app/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:chat_app/features/forget_password/data/data_sources/forget_password_remote_data_source.dart';
import 'package:chat_app/features/forget_password/data/repositories/forget_password_repository_impl.dart';
import 'package:chat_app/features/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:chat_app/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:chat_app/features/forget_password/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_app/features/groups/data/data_sources/groups_remote_data_source.dart';
import 'package:chat_app/features/groups/data/repositories/groups_repository_imp.dart';
import 'package:chat_app/features/groups/domain/repositories/groups_repository.dart';
import 'package:chat_app/features/groups/domain/use_cases/create_groups_use_case.dart';
import 'package:chat_app/features/groups/domain/use_cases/get_all_users_use_case.dart';
import 'package:chat_app/features/groups/domain/use_cases/get_groups_use_case.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/message/data/data_sources/message_remote_data_source.dart';
import 'package:chat_app/features/message/data/repositories/message_repo_impl.dart';
import 'package:chat_app/features/message/domain/repositories/message_repo.dart';
import 'package:chat_app/features/message/domain/use_cases/delete_room_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/get_message_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/read_message_use_case.dart';
import 'package:chat_app/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message_groups/data/data_source/message_groups_remote_data_source.dart';
import 'package:chat_app/features/message_groups/data/repositories/message_groups_repository_impl.dart';
import 'package:chat_app/features/message_groups/domain/repositories/message_groups_repositories.dart';
import 'package:chat_app/features/message_groups/domain/use_cases/send_group_massege_use_case.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repositories.dart';
import 'package:chat_app/features/profile/domain/use_cases/profile_use_case.dart';
import 'package:chat_app/features/profile/domain/use_cases/update_profile_picture_use_case.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:chat_app/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:chat_app/features/sign_up/domain/use_cases/google_login_use_case.dart';
import 'package:chat_app/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_app/core/services/permission_service.dart';
import 'package:chat_app/features/first_feature/data/data_sources/first_feature_remote_data_source.dart';
import 'package:chat_app/features/first_feature/data/repositories/first_feature_repo_impl.dart';
import 'package:chat_app/features/first_feature/domain/repositories/first_feature_repo.dart';
import 'package:chat_app/features/first_feature/domain/use_cases/first_feature_uc.dart';
import 'package:chat_app/features/first_feature/presentation/manager/cat_fact_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/helpers/shared_prefrences.dart';
import 'core/network/netwok_info.dart';
import 'core/services/alert_service.dart';
import 'core/services/url_launcher_service.dart';

final getIt = GetIt.instance;

Future<void> getItInit() async {
  //! Features

  /// Blocs
  getIt.registerFactory<CatFactCubit>(() => CatFactCubit(featureUc: getIt()));
  getIt.registerFactory<AppCubit>(() => AppCubit());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: getIt()));
  getIt.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(forgotPasswordUseCase: getIt()));
  getIt.registerFactory<SignUpCubit>(
      () => SignUpCubit(signUpUseCase: getIt(), googleSignInUseCase: getIt(), cacheHelper: getIt()));
  getIt.registerFactory<MainCubit>(() => MainCubit());
  getIt.registerFactory<MoreCubit>(() => MoreCubit(cacheHelper: getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(
      getProfileUseCase: getIt(),
      updateProfileUseCase: getIt(),
      logoutUseCase: getIt(),
      updateProfilePictureUseCase: getIt()));
  getIt.registerFactory<CreateChatsCubit>(() => CreateChatsCubit(
      createChatsUseCase: getIt(), searchUsersUseCase: getIt()));
  getIt.registerFactory<GetChatsCubit>(
      () => GetChatsCubit(getChatsUseCase: getIt()));
  getIt.registerFactory<MessageCubit>(() => MessageCubit(
      getMessagesUseCase: getIt(),
      sendMessageUseCase: getIt(),
      readMessageUseCase: getIt(),
      getUserByIdUseCase: getIt(),
      deleteRoomUseCase: getIt(),
      clearChatMessagesUseCase: getIt(),
      uploadImageUseCase: getIt()));
  getIt.registerFactory<GroupsCubit>(() => GroupsCubit(
      createGroupsUseCase: getIt(),
      getGroupsUseCase: getIt(),
      getAllUsersUseCase: getIt()));
  getIt.registerFactory<MessegeGroupCubit>(() => MessegeGroupCubit(
      sendMessageUseCase: getIt(),
      repository: getIt(),
      uploadImageUseCase: getIt(),
      groupsRepository: getIt()));
  getIt.registerFactory<UploadImageCubit>(
      () => UploadImageCubit(featureUc: getIt()));

  /// Use cases
  getIt.registerLazySingleton<FirstFeatureUc>(
      () => FirstFeatureUc(firstFeatureRepository: getIt()));
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt()));
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(repository: getIt()));
  getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: getIt()));
  getIt.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(signUpRepository: getIt()));
  getIt.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(profileRepositories: getIt()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(profileRepositories: getIt()));
  getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(profileRepositories: getIt()));
  getIt.registerLazySingleton<CreateChatsUseCase>(
      () => CreateChatsUseCase(chatsRepositories: getIt()));
  getIt.registerLazySingleton<GetChatsUseCase>(
      () => GetChatsUseCase(chatsRepositories: getIt()));
  getIt.registerLazySingleton<SearchUsersUseCase>(
      () => SearchUsersUseCase(repository: getIt()));
  getIt.registerLazySingleton<ReadMessageUseCase>(
      () => ReadMessageUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<GetUserByIdUseCase>(
      () => GetUserByIdUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<CreateGroupsUseCase>(
      () => CreateGroupsUseCase(groupsRepository: getIt()));
  getIt.registerLazySingleton<GetGroupsUseCase>(
      () => GetGroupsUseCase(groupsRepository: getIt()));
  getIt.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(groupsRepository: getIt()));
  getIt.registerLazySingleton<SendGroupMessageUseCase>(
      () => SendGroupMessageUseCase(messageGroupsRepository: getIt()));
  getIt.registerLazySingleton<DeleteRoomUseCase>(
      () => DeleteRoomUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<ClearChatMessagesUseCase>(
      () => ClearChatMessagesUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<UploadImageUseCase>(
      () => UploadImageUseCase(uploadImageRepositories: getIt()));
  getIt.registerLazySingleton<UpdateProfilePictureUseCase>(
      () => UpdateProfilePictureUseCase(profileRepositories: getIt()));

  /// Repository
  getIt.registerLazySingleton<FirstFeatureRepository>(() =>
      FirstFeatureRepositoryImpl(
          networkInfo: getIt(), firstFeatureRemoteDataSource: getIt()));
  getIt.registerLazySingleton<LoginRepository>(() =>
      LoginRepositoryImpl(remoteDataSource: getIt(), cacheHelper: getIt()));
  getIt.registerLazySingleton<ForgetPasswordRepository>(
      () => ForgetPasswordRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<ProfileRepositories>(() => ProfileRepositoryImpl(
      networkInfo: getIt(),
      profileRemoteDataSource: getIt(),
      cacheHelper: getIt()));
  getIt.registerLazySingleton<ChatsRepositories>(() => ChatsRepositoryImpl(
      networkInfo: getIt(), chatsRemoteDataSource: getIt()));
  getIt.registerLazySingleton<MessageRepository>(() =>
      MessageRepoImpl(networkInfo: getIt(), messageRemoteDataSource: getIt()));
  getIt.registerLazySingleton<GroupsRepository>(
      () => GroupsRepositoryImp(remoteDataSource: getIt()));
  getIt.registerLazySingleton<MessageGroupsRepository>(() =>
      MessageGroupsRepositoryImpl(messageGroupsRemoteDataSource: getIt()));
  getIt.registerLazySingleton<UploadImageRepositories>(() =>
      UploadImageRepositoriesImpl(
          networkInfo: getIt(), uploadImageDataSource: getIt()));

  /// Data Sources
  getIt.registerLazySingleton<FirstFeatureRemoteDataSource>(
      () => FirstFeatureRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  getIt.registerLazySingleton<ForgetPasswordRemoteDataSource>(
      () => ForgetPasswordRemoteDataSourceImpl());
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
      () => SignUpRemoteDataSourceImpl());
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl());
  getIt.registerLazySingleton<ChatsRemoteDataSource>(
      () => ChatsRemoteDataSourceImpl());
  getIt.registerLazySingleton<MessageRemoteDataSource>(
      () => MessageRemoteDataSourceImpl());
  getIt.registerLazySingleton<GroupsRemoteDataSource>(
      () => GroupsRemoteDataSourceImpl());
  getIt.registerLazySingleton<MessageGroupsRemoteDataSource>(
      () => MessageGroupsRemoteDataSourceImpl());
  getIt.registerLazySingleton<UploadImageRemoteDataSource>(
      () => UploadImageRemoteDataSourceImpl(image: getIt()));

  /// Core
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: getIt()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: getIt()));

  /// External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => preferences);
  getIt.registerLazySingleton(() => AppInterceptors());
  // getIt.registerLazySingleton(() => LogInterceptor(
  //     request: true,
  //     requestBody: true,
  //     requestHeader: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true));
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(() => CacheHelper());
  getIt.registerLazySingleton(() => UrlLauncherService());
  getIt.registerLazySingleton(() => PermissionService());
  getIt.registerLazySingleton(() => AlertService());
  getIt.registerLazySingleton(() => PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ));
  getIt.registerLazySingleton(() => Dio());
}
