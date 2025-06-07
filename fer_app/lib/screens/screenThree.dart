import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Facial Emotion Recognition System',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Powered by CNN and Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              'version 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            ScaleTransition(
              scale: const AlwaysStoppedAnimation(1.5),
              child: Image.asset(
                'assets/images/fcicon.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The Facial Emotion Recognition System is an advanced software solution that uses Convolutional Neural Networks (CNN) for accurately detecting and analyzing emotions from facial expressions. It leverages deep learning techniques to classify facial features and extract emotional cues from images or live video streams.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'The Flutter framework powers the user interface of the Facial Emotion Recognition System. It enables seamless integration of the CNN model with the UI, allowing real-time emotion analysis and providing users with intuitive feedback and insights.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: FittedBox(
                    child: Text(
                      'Developed By Flutter_Dev:\nTheophilus Asamoah®™',
                      style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(
                          255,
                          15,
                          35,
                          206,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
