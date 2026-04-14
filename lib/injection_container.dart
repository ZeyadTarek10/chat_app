import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_helper/core/services/permission_service.dart';
import 'package:flutter_helper/features/first_feature/data/data_sources/first_feature_remote_data_source.dart';
import 'package:flutter_helper/features/first_feature/data/repositories/first_feature_repo_impl.dart';
import 'package:flutter_helper/features/first_feature/domain/repositories/first_feature_repo.dart';
import 'package:flutter_helper/features/first_feature/domain/use_cases/first_feature_uc.dart';
import 'package:flutter_helper/features/first_feature/presentation/manager/cat_fact_cubit.dart';
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

  /// Use cases
  getIt
      .registerLazySingleton<FirstFeatureUc>(() => FirstFeatureUc(firstFeatureRepository: getIt()));

  /// Repository
  getIt.registerLazySingleton<FirstFeatureRepository>(() =>
      FirstFeatureRepositoryImpl(networkInfo: getIt(), firstFeatureRemoteDataSource: getIt()));

  /// Data Sources
  getIt.registerLazySingleton<FirstFeatureRemoteDataSource>(
      () => FirstFeatureRemoteDataSourceImpl(client: getIt()));

  /// Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: getIt()));
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
