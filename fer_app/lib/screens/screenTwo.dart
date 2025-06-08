import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class LiveStreamDetection extends StatefulWidget {
  final List<CameraDescription> cameras;
  const LiveStreamDetection(this.cameras, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<LiveStreamDetection> {
  int cam = 0;
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';

  loadModel() async {
    Tflite.loadModel(
      model: 'assets/model/my_model.tflite',
      labels: 'assets/model/labels.txt',
    );
  }

  loadCamera() {
    cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.high);
    cameraController!.initialize().then(
      (value) {
        if (!mounted) {
          return;
        } else {
          setState(
            () {
              cameraController!.startImageStream(
                (
                  imageStream,
                ) {
                  cameraImage = imageStream;
                  runModel();
                },
              );
            },
          );
        }
      },
    );
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map(
            (plane) {
              return plane.bytes;
            },
          ).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 7,
          threshold: 0.1,
          asynch: true);

      output = '';

      for (var element in predictions!) {
        // ignore: prefer_interpolation_to_compose_strings
        output += element['label'].toString().substring(0, 1).toUpperCase() +
            element['label'].toString().substring(1) +
            " " +
            (element['confidence'] as double).toStringAsFixed(2) +
            '\n';
      }
      setState(
        () {
          output = output;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  @override
  void dispose() async {
    super.dispose();

    await Tflite.close();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recognition using Camera'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Bring your face here'),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 25.0,
                width: 45.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (cam == 1) {
                      cam = 0;
                    } else {
                      cam = 1;
                    }
                    loadCamera();
                  },
                  child: const Text(
                    '🔄',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: !cameraController!.value.isInitialized
                    ? Container()
                    : AspectRatio(
                        aspectRatio: cameraController!.value.aspectRatio,
                        child: CameraPreview(cameraController!),
                      ),
              ),
            ),
            Container(
              width: 300,
              height: 100,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  9,
                  54,
                  130,
                ),
                border: Border.all(
                    color: const Color.fromARGB(
                      255,
                      35,
                      62,
                      39,
                    ),
                    width: 3.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
