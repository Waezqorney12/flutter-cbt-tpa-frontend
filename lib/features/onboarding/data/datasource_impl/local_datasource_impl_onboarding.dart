
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasource/local_datasource_onboarding.dart';

class LocalDataSourceOnboardingImpl implements LocalDataSourceOnboarding {
  final SharedPreferences sharedPreferences;
  LocalDataSourceOnboardingImpl({required this.sharedPreferences});
  @override
  Future<bool> getOnboarding() async => sharedPreferences.getBool('isOnBoarding') ?? false;

  @override
  Future<bool> setOnboarding() => sharedPreferences.setBool('isOnBoarding', true);
}
