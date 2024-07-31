import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_potensial/features/onboarding/controller/onboarding_controller.dart';
import 'package:test_potensial/init_dependencies.dart';
import 'package:test_potensial/core/routes/routes_pages.dart';
import 'package:test_potensial/core/shared/positioned/dimensions.dart';
import 'package:test_potensial/core/theme/app_palette.dart';

import '../../../core/shared/text_style/text_app_style.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {
  late OnBoardingController onBoardingController;
  late List<AnimationController> _animationController;
  late List<Animation<double>?> _animation;
  late PageController _pageController;

  @override
  void initState() {
    onBoardingController = getIt<OnBoardingController>();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        OnBoardingController.currentIndex = _pageController.page!.round();
      });
    });

    _animationController = List.generate(
      OnBoardingController.screenPage.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      ),
    );

    _animation = _animationController.map((value) => Tween(begin: 0.0, end: 1.0).animate(value)).toList();
    _animationController[OnBoardingController.currentIndex].forward();
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _animationController) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 28),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset('assets/onboarding/ornament.svg'),
                Positioned(
                  right: 0,
                  top: Dimensions.height50(context),
                  child: Row(
                    children: [
                      Text(
                        'Skip',
                        style: TextAppStyle.montserratMedium.copyWith(
                          fontSize: 18,
                          color: AppPalette.boardingTextColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () => onBoardingController.setOnboarding().then(
                              (value) => Navigator.pushReplacement(
                                context,
                                Routes.login(),
                              ),
                            ),
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: Dimensions.minHeight100(context),
                  child: SizedBox(
                    height: 320,
                    width: 287,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) {
                        for (final i in _animationController.indexed) {
                          final indexes = i.$1;
                          if (indexes == index) {
                            _animationController[indexes].forward();
                          } else {
                            _animationController[indexes].reset();
                          }
                        }
                      },
                      children: List.generate(OnBoardingController.screenPage.length, (index) {
                        return AnimatedBuilder(
                          animation: _animation[index]!,
                          builder: (context, child) {
                            return Opacity(
                                opacity: _animation[index]?.value ?? 0,
                                child: SvgPicture.asset(OnBoardingController.screenPage[index].toString()));
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              textAlign: TextAlign.center,
              'Jelajahi Potensimu dengan Tes\nOnline Akademik di CWB !',
              style: TextAppStyle.montserratSemiBold.copyWith(
                fontSize: 16,
                color: AppPalette.boardingTextColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: OnBoardingController.screenPage.keys.map((index) {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: OnBoardingController.currentIndex == index ? AppPalette.primaryColor : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (OnBoardingController.currentIndex == 2) {
                    onBoardingController.setOnboarding().then(
                          (value) => Navigator.pushReplacement(
                            context,
                            Routes.login(),
                          ),
                        );
                  } else {
                    setState(() {
                      OnBoardingController.currentIndex++;
                      _pageController.animateToPage(
                        OnBoardingController.currentIndex,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                    });
                  }
                },
                child: Text(
                  'Continue',
                  style: TextAppStyle.montserratSemiBold.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
