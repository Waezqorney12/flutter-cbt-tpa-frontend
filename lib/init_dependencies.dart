import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // Used for DI (Dependency Injection) Onboarding Feature
  _initOnboardingFeature();
}

void _initOnboardingFeature() {
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(
      localDataSourceOnboarding: getIt<LocalDataSourceOnboarding>(),
    ),
  );
  getIt.registerSingleton<LocalDataSourceOnboarding>(
    LocalDataSourceOnboardingImpl(
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );
  getIt.registerLazySingleton<OnBoardingController>(
    () => OnBoardingController(
      onboardingRepository: getIt<OnboardingRepository>(),
    ),
  );
}
