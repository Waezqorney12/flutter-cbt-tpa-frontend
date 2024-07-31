import 'package:test_potensial/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../../domain/datasource/local_datasource_onboarding.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final LocalDataSourceOnboarding localDataSourceOnboarding;
  OnboardingRepositoryImpl({required this.localDataSourceOnboarding});

  @override
  Future<bool> getOnboarding() {
    try {
      return localDataSourceOnboarding.getOnboarding();
    } catch (e) {
      Log.loggerError(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> setOnboarding() {
    try {
      return localDataSourceOnboarding.setOnboarding();
    } catch (e) {
      Log.loggerError(e.toString());
      rethrow;
    }
  }
}
