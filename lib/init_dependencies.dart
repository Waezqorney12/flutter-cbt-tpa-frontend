import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_potensial/core/infrastructure/network/websocket_client.dart';
import 'package:test_potensial/core/token/flutter_secure_store.dart';
import 'package:test_potensial/core/token/shared_preferences.dart';
import 'package:test_potensial/features/auth/bloc/forgot_password_bloc.dart';
import 'package:test_potensial/features/auth/data/repository_impl/forgot_password_repository_impl.dart';
import 'package:test_potensial/features/auth/domain/datasource/forgot_password_remote_datasource.dart';
import 'package:test_potensial/features/auth/domain/repository/forgot_password_repository.dart';
import 'package:test_potensial/features/auth/domain/usecases/user_forgot_password_usecases.dart';
import 'package:test_potensial/features/history_nilai/presentation/cubit/history_nilai_cubit.dart';
import 'package:test_potensial/features/history_nilai/data/datasource_impl/history_nilai_remote_datasource_impl.dart';
import 'package:test_potensial/features/history_nilai/data/repository_impl/history_nilai_repository_impl.dart';
import 'package:test_potensial/features/history_nilai/domain/datasource/history_nilai_remote_datasource.dart';
import 'package:test_potensial/features/history_nilai/domain/repository/history_nilai_repository.dart';
import 'package:test_potensial/features/history_nilai/domain/usecase/history_nilai_usecase.dart';
import 'package:test_potensial/features/materi/presentation/bloc/materi_bloc.dart';
import 'package:test_potensial/features/materi/data/datasource/materi_remote_datasource_impl.dart';
import 'package:test_potensial/features/materi/data/repository/materi_repository_impl.dart';
import 'package:test_potensial/features/materi/domain/datasource/materi_remote_datasource.dart';
import 'package:test_potensial/features/materi/domain/repository/materi_repository.dart';
import 'package:test_potensial/features/materi/domain/usecases/materi_usecases.dart';
import 'package:test_potensial/features/profile_detail/data/datasource_impl/profile_detail_remote_impl_datasource.dart';
import 'package:test_potensial/features/profile_detail/data/repository_impl/profile_detail_repository_impl.dart';
import 'package:test_potensial/features/profile_detail/domain/datasource/profile_detail_datasource.dart';
import 'package:test_potensial/features/profile_detail/domain/usecase/profile_detail_usecase.dart';
import 'package:test_potensial/features/quiz/cubit/quiz_thumbnail_cubit.dart';
import 'package:test_potensial/features/quiz/data/repository_impl/quiz_thumbnail_repository_impl.dart';
import 'package:test_potensial/features/quiz/domain/datasource/quiz_thumbnail_remote_datasource.dart';
import 'package:test_potensial/features/quiz/domain/repository/quiz_thumbnail_repository.dart';
import 'package:test_potensial/features/quiz/domain/usecase/quiz_thumbnail_usecase.dart';
import 'package:test_potensial/features/quiz_detail/bloc/quiz_detail_bloc.dart';
import 'package:test_potensial/features/quiz_detail/data/datasource/remote_quiz_detail_datasource_impl.dart';
import 'package:test_potensial/features/quiz_detail/data/repository/quiz_detail_repository_impl.dart';
import 'package:test_potensial/features/quiz_detail/domain/datasource/remote_quiz_detail_datasource.dart';
import 'package:test_potensial/features/quiz_detail/domain/repository/quiz_detail_repository.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';
import 'package:test_potensial/features/quiz_nilai/bloc/quiz_nilai_bloc.dart';
import 'package:test_potensial/features/quiz_nilai/data/repository/quiz_nilai_repository_impl.dart';
import 'package:test_potensial/features/quiz_nilai/domain/datasource/quiz_nilai_datasource.dart';
import 'package:test_potensial/features/quiz_nilai/domain/repository/quiz_nilai_repository.dart';
import 'package:test_potensial/features/quiz_nilai/domain/usecase/quiz_nilai_usecase.dart';
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

import 'features/auth/data/datasource_impl/forgot_password_remote_datasource_impl.dart';
import 'features/auth/data/datasource_impl/login_remote_datasource_impl.dart';
import 'features/auth/data/repository_impl/login_repository_impl.dart';
import 'features/auth/domain/datasource/login_remote_datasource.dart';
import 'features/auth/domain/repository/login_repository.dart';
import 'features/profile_detail/cubit/profile_detail_cubit.dart';
import 'features/profile_detail/domain/repository/profile_detail_repository.dart';
import 'features/quiz/data/datasource_impl/quiz_thumbnail_remote_datasource_impl.dart';
import 'features/quiz_nilai/data/datasource/quiz_nilai_datasource_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final WebsocketService service = WebsocketService();

  _initNetwork(sharedPreferences, secureStorage, service);
  // Used for DI (Dependency Injection)  Feature
  _initFeature();
}

void _initNetwork(
  SharedPreferences sharedPreferences,
  FlutterSecureStorage secureStorage,
  WebsocketService service,
) {
  getIt
    ..registerSingleton<DioClient>(DioClient())
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerSingleton<WebsocketService>(service)
    ..registerSingleton<FlutterSecureStorage>(secureStorage);
}

void _initFeature() {
  getIt

    // RemoteDatasource
    ..registerFactory<QuizThumbnailRemoteDatasource>(
      () => QuizThumbnailRemoteDatasourceImpl(
        getIt<DioClient>(),
        getIt<TokenLocalDatasource>(),
      ),
    )
    ..registerFactory<ForgotPasswordRemoteDataSource>(
      () => ForgotPasswordRemoteDataSourceImpl(
        getIt<DioClient>(),
      ),
    )
    ..registerFactory<ProfileDetailDatasource>(
      () => ProfileDetailRemoteImplDatasource(
        getIt<DioClient>(),
        getIt<TokenLocalDatasource>(),
      ),
    )
    ..registerFactory<HistoryNilaiRemoteDatasource>(
      () => HistoryNilaiRemoteDatasourceImpl(
        getIt<TokenLocalDatasource>(),
        getIt<DioClient>(),
      ),
    )
    ..registerFactory<QuizNilaiDatasource>(
      () => QuizNilaiDatasourceImpl(
        getIt<DioClient>(),
        getIt<TokenLocalDatasource>(),
      ),
    )
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
        getIt<SharedPreferencesSecureInterface>(),
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
        //getIt<TokenLocalDatasource>(),
      ),
    )

    // LocalDatasource

    ..registerSingleton<SharedPreferencesSecureInterface>(
      SharedPreferencesSecureImpl(
        getIt<FlutterSecureStorage>(),
      ),
    )
    ..registerSingleton<SharedPreferencesInterface>(
      SharedPreferencesImpl(
        getIt<SharedPreferences>(),
      ),
    )
    ..registerSingleton<LocalDataSourceOnboarding>(
      LocalDataSourceOnboardingImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    )

    // Repository
    ..registerFactory<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImpl(
        getIt<ForgotPasswordRemoteDataSource>(),
      ),
    )
    ..registerFactory<ProfileDetailRepository>(
      () => ProfileDetailRepositoryImpl(
        getIt<ProfileDetailDatasource>(),
      ),
    )
    ..registerFactory<HistoryNilaiRepository>(
      () => HistoryNilaiRepositoryImpl(
        historyNilaiRemoteDatasource: getIt<HistoryNilaiRemoteDatasource>(),
      ),
    )
    ..registerFactory<QuizThumbnailRepository>(
      () => QuizThumbnailRepositoryImpl(
        getIt<QuizThumbnailRemoteDatasource>(),
      ),
    )
    ..registerFactory<QuizNilaiRepository>(
      () => QuizNilaiRepositoryImpl(
        getIt<QuizNilaiDatasource>(),
      ),
    )
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
      () => QuizThumbnailUsecase(
        getIt<QuizThumbnailRepository>(),
      ),
    )
    ..registerFactory(
      () => UserSendEmailUsecases(
        getIt<ForgotPasswordRepository>(),
      ),
    )
    ..registerFactory(
      () => UserVerifyOtpCodeUsecases(
        getIt<ForgotPasswordRepository>(),
      ),
    )
    ..registerFactory(
      () => ProfileDetailUseCase(
        getIt<ProfileDetailRepository>(),
      ),
    )
    ..registerFactory(
      () => HistoryNilaiUsecase(
        getIt<HistoryNilaiRepository>(),
      ),
    )
    ..registerFactory(
      () => UserExitUseCase(
        getIt<QuizDetailRepository>(),
      ),
    )
    ..registerFactory(
      () => GetNilaiJawabanUseCase(
        getIt<QuizNilaiRepository>(),
      ),
    )
    ..registerFactory(
      () => CreateJawabanDetailUseCase(
        getIt<QuizDetailRepository>(),
      ),
    )
    ..registerFactory(
      () => GetQuizDetailUseCase(
        getIt<QuizDetailRepository>(),
      ),
    )
    ..registerFactory(
      () => GetMateriUseCase(
        getIt<MateriRepository>(),
      ),
    )
    ..registerFactory(
      () => UpdateMateriUseCase(
        getIt<MateriRepository>(),
      ),
    )
    ..registerFactory(
      () => UserLoginUseCase(
        getIt(),
      ),
    )
    ..registerFactory(
      () => UserRegisterUseCase(
        getIt(),
      ),
    )

    // Cubit
    ..registerLazySingleton(
      () => QuizThumbnailCubit(
        thumbnailUsecase: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => ProfileDetailCubit(
        useCase: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => HistoryNilaiCubit(
        useCase: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => UserCubit(
        getIt(),
      ),
    )

    // Bloc

    ..registerLazySingleton(
      () => ForgotPasswordBloc(
        userSendEmail: getIt(),
        userVerifyOtpCode: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => QuizNilaiBloc(
        nilaiUsecase: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => QuizDetailBloc(
        userExitUseCase: getIt(),
        getQuizDetail: getIt(),
        createJawaban: getIt(),
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
