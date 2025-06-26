import 'package:camera/camera.dart';
import 'package:fer_app/screens/screenOne.dart';
import 'package:flutter/material.dart';

class OperationZero extends StatefulWidget {
  final CameraDescription cam;
  final List<CameraDescription> camm;
  const OperationZero(this.camm, this.cam, {Key? key}) : super(key: key);

  @override
  State<OperationZero> createState() => _OperationZeroState();
}

class _OperationZeroState extends State<OperationZero>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      _animationController,
    );

    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/Facial-Recognition.jpg',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        20,
                      ),
                      margin: const EdgeInsets.all(
                        20,
                      ),
                      child: const FittedBox(
                        child: Text(
                          'Facial Emotion Recognition',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(
                              255,
                              255,
                              255,
                              254,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(
                            106,
                            32,
                            156,
                            82,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(
                          0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstScreen(
                              widget.camm,
                              widget.cam,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.fast_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Let\'s Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
