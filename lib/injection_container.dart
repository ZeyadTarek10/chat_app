import 'package:chat_app/features/Login/data/data_sources/login_remote_data_source.dart';
import 'package:chat_app/features/Login/data/repositories/login_repository_impl.dart';
import 'package:chat_app/features/Login/domain/repositories/login_repository.dart';
import 'package:chat_app/features/Login/domain/use_cases/login_use_case.dart';
import 'package:chat_app/features/Login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:chat_app/features/forget_password/data/data_sources/forget_password_remote_data_source.dart';
import 'package:chat_app/features/forget_password/data/repositories/forget_password_repository_impl.dart';
import 'package:chat_app/features/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:chat_app/features/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:chat_app/features/forget_password/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:chat_app/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:chat_app/features/sign_up/domain/repositories/sign_up_repository.dart';
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
  getIt.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: getIt()));
  getIt.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(forgotPasswordUseCase: getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(signUpUseCase: getIt()));
  getIt.registerFactory<MainCubit>(() => MainCubit());
  getIt.registerFactory<MoreCubit>(() => MoreCubit(cacheHelper: getIt()));

  /// Use cases
  getIt.registerLazySingleton<FirstFeatureUc>(
      () => FirstFeatureUc(firstFeatureRepository: getIt()));
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt()));
  getIt.registerLazySingleton<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(repository: getIt()));
  getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: getIt()));

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

  /// Data Sources
  getIt.registerLazySingleton<FirstFeatureRemoteDataSource>(
      () => FirstFeatureRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  getIt.registerLazySingleton<ForgetPasswordRemoteDataSource>(
      () => ForgetPasswordRemoteDataSourceImpl());
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
      () => SignUpRemoteDataSourceImpl());

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
