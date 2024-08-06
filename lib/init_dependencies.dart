import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/cubit/user_cubit.dart';
import '../core/infrastructure/network/dio_client.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/data/datasource_impl/register_remote_datasource_impl.dart';
import '../core/token/token_local_datasource.dart';
import '../features/auth/data/repository_impl/register_repository_impl.dart';
import '../features/auth/domain/datasource/register_remote_datasource.dart';
import '../features/auth/domain/repository/register_repository.dart';
import '../features/auth/domain/usecases/user_login_usecases.dart';
import '../features/auth/domain/usecases/user_register_usecases.dart';
import '../features/onboarding/controller/onboarding_controller.dart';
import '../features/onboarding/data/datasource_impl/local_datasource_impl_onboarding.dart';
import '../features/onboarding/data/repository/onboarding_repository_impl.dart';
import '../features/onboarding/domain/datasource/local_datasource_onboarding.dart';
import '../features/onboarding/domain/repository/onboarding_repository.dart';

import 'features/auth/data/datasource_impl/login_remote_datasource_impl.dart';
import 'features/auth/data/repository_impl/login_repository_impl.dart';
import 'features/auth/domain/datasource/login_remote_datasource.dart';
import 'features/auth/domain/repository/login_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Used for DI (Dependency Injection) Shared Preferences
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<DioClient>(DioClient());

  // Used for DI (Dependency Injection) Onboarding Feature
  _initOnboardingFeature();
}

void _initOnboardingFeature() {
  getIt
    // RemoteDatasource
    ..registerFactory<TokenLocalDatasource>(
      () => TokenLocalDatasourceImpl(
        getIt<SharedPreferences>(),
        getIt<DioClient>(),
      ),
    )
    ..registerFactory<LoginRemoteDataSource>(
      () => LoginRemoteDatasourceImpl(
        getIt<DioClient>(),
        getIt<TokenLocalDatasource>(),
      ),
    )
    ..registerFactory<RegisterRemoteDataSource>(
      () => RegisterRemoteDatasourceImpl(
        getIt<DioClient>(),
        getIt<TokenLocalDatasource>(),
      ),
    )

    // LocalDatasource
    ..registerSingleton<LocalDataSourceOnboarding>(
      LocalDataSourceOnboardingImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    )

    // Repository
    ..registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(
        getIt<LoginRemoteDataSource>(),
      ),
    )
    ..registerFactory<RegisterRepository>(
      () => RegisterRepositoryImpl(
        getIt<RegisterRemoteDataSource>(),
      ),
    )
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(
        localDataSourceOnboarding: getIt<LocalDataSourceOnboarding>(),
      ),
    )

    // Controller
    ..registerLazySingleton<OnBoardingController>(
      () => OnBoardingController(
        onboardingRepository: getIt<OnboardingRepository>(),
      ),
    )

    // UseCases
    ..registerFactory(
      () => UserLogin(
        getIt(),
      ),
    )
    ..registerFactory(
      () => UserRegister(
        getIt(),
      ),
    )
    // Cubit
    ..registerLazySingleton(
      () => UserCubit(
        getIt(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userLogin: getIt(),
        userRegister: getIt(),
      ),
    );
}
