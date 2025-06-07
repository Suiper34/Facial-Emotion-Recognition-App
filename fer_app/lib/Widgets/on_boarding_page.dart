import 'package:fer_app/models/on_boarding_screen_content.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<OnboardingScreenContent> onboardingScreens = [
  OnboardingScreenContent(
    title: 'Interactive Interface',
    description: 'Scan for faces',
    imagePath: 'assets/images/scanFace.png',
  ),
  OnboardingScreenContent(
    title: 'Real-time Facial Emotion Recognition',
    description: 'Detect and analyze emotions from faces detected.',
    imagePath: 'assets/images/facRec.png',
  ),
  OnboardingScreenContent(
    title: 'Live Emotion Feedback',
    description: 'Get instant feedback on detected emotions in real-time.',
    imagePath: 'assets/images/DET.png',
  ),
];
