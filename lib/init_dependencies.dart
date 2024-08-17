import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/features/materi/bloc/materi_bloc.dart';
import 'package:test_potensial/features/materi/data/datasource/materi_remote_datasource_impl.dart';
import 'package:test_potensial/features/materi/data/repository/materi_repository_impl.dart';
import 'package:test_potensial/features/materi/domain/datasource/materi_remote_datasource.dart';
import 'package:test_potensial/features/materi/domain/repository/materi_repository.dart';
import 'package:test_potensial/features/materi/domain/usecases/materi_usecases.dart';
import 'package:test_potensial/features/quiz_detail/bloc/quiz_detail_bloc.dart';
import 'package:test_potensial/features/quiz_detail/data/datasource/remote_quiz_detail_datasource_impl.dart';
import 'package:test_potensial/features/quiz_detail/data/repository/quiz_detail_repository_impl.dart';
import 'package:test_potensial/features/quiz_detail/domain/datasource/remote_quiz_detail_datasource.dart';
import 'package:test_potensial/features/quiz_detail/domain/repository/quiz_detail_repository.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';
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
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  _initNetwork(sharedPreferences);
  // Used for DI (Dependency Injection)  Feature
  _initFeature();
}

void _initNetwork(SharedPreferences sharedPreferences) {
  getIt
    ..registerSingleton<DioClient>(DioClient())
    ..registerSingleton<SharedPreferences>(sharedPreferences);
}

void _initFeature() {
  getIt
    // RemoteDatasource
    ..registerFactory<RemoteQuizDetailDatasource>(
      () => RemoteQuizDetailDatasourceImpl(
        getIt<TokenLocalDatasource>(),
        getIt<DioClient>(),
      ),
    )
    ..registerFactory<MateriRemoteDataSource>(
      () => MateriRemoteDatasourceImpl(
        getIt<DioClient>(),
        getIt<TokenLocalDatasource>(),
      ),
    )
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

    ..registerFactory<QuizDetailRepository>(
      () => QuizDetailRepositoryImpl(
        getIt<RemoteQuizDetailDatasource>(),
      ),
    )
    ..registerFactory<MateriRepository>(
      () => MateriRepositoryImpl(
        getIt<MateriRemoteDataSource>(),
      ),
    )
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
      () => GetQuizDetail(
        getIt<QuizDetailRepository>(),
      ),
    )
    ..registerFactory(
      () => GetMateri(
        getIt<MateriRepository>(),
      ),
    )
    ..registerFactory(
      () => UpdateMateri(
        getIt<MateriRepository>(),
      ),
    )
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
      () => QuizDetailBloc(
        getQuizDetail: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => MateriBloc(
        getMateri: getIt(),
        updateMateri: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userLogin: getIt(),
        userRegister: getIt(),
      ),
    );
}
