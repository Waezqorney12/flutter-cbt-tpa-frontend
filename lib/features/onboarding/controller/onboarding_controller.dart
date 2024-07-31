import 'package:test_potensial/features/onboarding/domain/repository/onboarding_repository.dart';

class OnBoardingController {
  final OnboardingRepository onboardingRepository;

  OnBoardingController({required this.onboardingRepository});
  static int currentIndex = 0;

  static Map<int, String> screenPage = {
    0: 'assets/onboarding/screen-1.svg',
    1: 'assets/onboarding/screen-2.svg',
    2: 'assets/onboarding/screen-3.svg',
  };

  Future setOnboarding() => onboardingRepository.setOnboarding();
}
