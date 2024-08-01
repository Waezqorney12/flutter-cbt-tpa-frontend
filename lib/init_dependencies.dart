import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/features/auth/bloc/auth_bloc.dart';
import 'package:test_potensial/features/auth/data/datasource_impl/register_remote_datasource_impl.dart';
import 'package:test_potensial/features/auth/data/repository_impl/register_repository_impl.dart';
import 'package:test_potensial/features/auth/domain/datasource/register_remote_datasource.dart';
import 'package:test_potensial/features/auth/domain/repository/register_repository.dart';
import 'package:test_potensial/features/auth/domain/usecases/user_register_usecases.dart';
import 'package:test_potensial/features/onboarding/controller/onboarding_controller.dart';
import 'package:test_potensial/features/onboarding/data/datasource_impl/local_datasource_impl_onboarding.dart';
import 'package:test_potensial/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:test_potensial/features/onboarding/domain/datasource/local_datasource_onboarding.dart';
import 'package:test_potensial/features/onboarding/domain/repository/onboarding_repository.dart';

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
    ..registerFactory<RegisterRemoteDataSource>(
      () => RegisterRemoteDatasourceImpl(
        getIt<DioClient>(),
      ),
    )

    // LocalDatasource
    ..registerSingleton<LocalDataSourceOnboarding>(
      LocalDataSourceOnboardingImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    )

    // Repository
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
      () => UserRegister(
        getIt(),
      ),
    )

    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userRegister: getIt(),
      ),
    );
}
