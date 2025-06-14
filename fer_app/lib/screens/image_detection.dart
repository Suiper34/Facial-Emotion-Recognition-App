import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ImageClassificationPagey extends StatefulWidget {
  final CameraDescription camera;

  const ImageClassificationPagey({Key? key, required this.camera})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImageClassificationPageState createState() =>
      _ImageClassificationPageState();
}

class _ImageClassificationPageState extends State<ImageClassificationPagey> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String _result = '';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/my_model.tflite',
      labels: 'assets/model/labels.txt',
    );
  }

  Future<void> _classifyImage(File? image) async {
    if (image == null) return;

    setState(
      () {
        _isProcessing = true;
      },
    );

    final List? results = await Tflite.runModelOnImage(
      path: image.path,
    );

    setState(
      () {
        _isProcessing = false;
        _result = results!.isNotEmpty ? results[0]['label'] : 'No result found';
      },
    );
  }

  Future<void> _startVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    try {
      await _initializeControllerFuture;
      final directory = await getApplicationDocumentsDirectory();
      // ignore: unused_local_variable
      final videoPath = path.join(
        directory.path,
        '${DateTime.now()}.mp4',
      );

      await _controller.startVideoRecording();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) return;

    try {
      await _controller.stopVideoRecording();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Classification'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    )
                  : Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _startVideoRecording,
              child: const Text('Start Recording'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _stopVideoRecording,
              child: const Text('Stop Recording'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isProcessing
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      // Perform classification on the recorded video
                    },
                    child: const Text('Classify Video'),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Result: $_result',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _takePhoto();
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _takePhoto() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      await _classifyImage(imageFile);
    }
  }
}
