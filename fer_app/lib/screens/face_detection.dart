import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionRecognitionOnImage extends StatefulWidget {
  const EmotionRecognitionOnImage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmotionRecognitionHomePageState createState() =>
      _EmotionRecognitionHomePageState();
}

class _EmotionRecognitionHomePageState
    extends State<EmotionRecognitionOnImage> {
  dynamic _image;

  List<Face> _faces = [];
  List<dynamic> _outputs = [];
  bool _loading = false;

  final picker = ImagePicker();

  Future<File?> _captureImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/captured_image.jpg';
    final imageFile = File(imagePath);

    final savedImage = await imageFile.copy(imagePath);
    return savedImage;
  }

  Future<void> _getImageFromCamera() async {
    final savedImage = await _captureImage();
    if (savedImage != null) {
      setState(() {
        _image = savedImage;
        _faces = [];
        _outputs = [];
      });
      _detectFaces();
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _faces = [];
        _outputs = [];
      });
      _detectFaces();
    }
  }

  Future<void> _detectFaces() async {
    setState(() {
      _loading = true;
    });

    final image = InputImage.fromFile(_image);
    final faceDetector = GoogleMlKit.vision.faceDetector();

    final faces = await faceDetector.processImage(image);

    setState(() {
      _faces = faces;
      _loading = false;
    });

    await _detectEmotion();
  }


  Future<void> _detectEmotion() async {
    final interpreter =
        await Interpreter.fromAsset('assets/model/mobilenet_7.tflite');
    final inputShape = interpreter.getInputTensor(0).shape;

    final imageBytes = await _image.readAsBytes();
    final rawImage = img.decodeImage(imageBytes);
    final image =
        img.copyResize(rawImage!, width: inputShape[1], height: inputShape[2]);
    final input = image.data?.buffer.asUint8List();

    final outputTensor = interpreter.getOutputTensor(0);
    final outputBuffer =
        Float32List(outputTensor.shape.reduce((a, b) => a * b));

    interpreter.run(input!, outputBuffer);

    setState(() {
      _outputs = outputBuffer.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Classification'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _image == null
                  ? const Text(
                      'No image selected!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Image.file(_image),
            ),
          ),
          if (_loading)
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Color.fromRGBO(
                  47,
                  35,
                  90,
                  0.348,
                ),
              ),
              color: Color.fromARGB(
                44,
                58,
                141,
                79,
              ),
            )
          // ignore: unnecessary_null_comparison
          else if (_faces != null)
            Text('Number of faces detected: ${_faces.length}'),
          // ignore: unnecessary_null_comparison
          if (_outputs != null)
            Text('Emotion: ${_getEmotionLabel(_outputs[0])}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _getImageFromCamera,
              child: const Text('Take Photo'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
          ),
        ],
      ),
    );
  }

  String _getEmotionLabel(double emotionIndex) {
    final File labelsFile = File('assets/model/affectnet_labels.txt');
    final labels = labelsFile.readAsLinesSync();
    final index = emotionIndex.toInt();

    if (index >= 0 && index < labels.length) {
      return labels[index];
    } else {
      return 'Unknown';
    }
  }
}
