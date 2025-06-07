import 'package:camera/camera.dart';
import 'package:fer_app/Widgets/on_boarding_page.dart';
import 'package:fer_app/screens/screen_Zero.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  final CameraDescription cam;
  final List<CameraDescription> camm;
  OnBoardingScreen(this.cam, this.camm, {super.key});

  final PageController _pageController = PageController();

  void _navigateToMainScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (
          context,
        ) =>
            OperationZero(camm, cam),
      ),
    );
  }

  final bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingScreens.length,
            itemBuilder: (
              context,
              index,
            ) {
              return OnboardingPage(
                title: onboardingScreens[index].title,
                description: onboardingScreens[index].description,
                imagePath: onboardingScreens[index].imagePath,
              );
            },
          ),
          Container(
            alignment: const Alignment(0, 0.82),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _navigateToMainScreen(context);
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        146,
                        27,
                        19,
                      ),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                ),
                TextButton(
                  onPressed: () {
                    if (_pageController.page!.toInt() <
                        onboardingScreens.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Handle onboarding completion
                      // navigating to the home screen
                      _navigateToMainScreen(context);
                    }
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
