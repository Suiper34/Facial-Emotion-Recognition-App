import 'package:camera/camera.dart';
// ignore: unused_import
import 'package:fer_app/screens/detection_on_image.dart';
import 'package:fer_app/screens/face_detection.dart';
import 'package:fer_app/screens/image_detection.dart';
import 'package:fer_app/screens/screenThree.dart';
import 'package:fer_app/screens/screenTwo.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  final CameraDescription camerra;
  final List<CameraDescription> cammerra;
  const FirstScreen(this.cammerra, this.camerra, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FirstScreen createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          image: AssetImage(
            'assets/images/Facial-Recognitionn.jpg',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 150,
              bottom: 80,
            ),
            // color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  margin: const EdgeInsets.all(
                    15,
                  ),
                  child: FittedBox(
                    child: Text(
                      "Hello, Welcome To The F.E.R App",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                          0,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(
                            106,
                            9,
                            86,
                            40,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LiveStreamDetection(widget.cammerra),
                          ),
                        );
                      },
                      child: const Text(
                        "Live Detection",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                          0,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(
                            106,
                            6,
                            91,
                            40,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EmotionRecognitionOnImage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Image Detection",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(
                          0,
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(
                            106,
                            6,
                            91,
                            40,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageClassificationPagey(
                                camera: widget.camerra),
                          ),
                        );
                      },
                      child: const Text(
                        "Live/Image Recognition",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtonTheme(
                      minWidth: 120.0,
                      height: 120.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutPage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(
                            0,
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(
                              106,
                              9,
                              85,
                              39,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                60,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "About",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
}
