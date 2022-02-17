import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;
  final Function(String, String) onImageTaken;

  CameraScreen({@required this.camera, @required this.onImageTaken});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.veryHigh,
    );

    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: SizedBox(
                height: _cameraController.value.previewSize.height,
                width: _cameraController.value.previewSize.width,
                child: CameraPreview(_cameraController),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Icon(
              Icons.camera_alt,
              size: 50,
            ),
          ),
          isExtended: true,
          onPressed: onTapTakeImage,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  onTapTakeImage() async {
    try {
      await _initializeControllerFuture;

      final fullImage = await _cameraController.takePicture();
      Directory tempDir = await getTemporaryDirectory();

      final image = File(tempDir.path + '/${fullImage.name}');
      await image.writeAsBytes(await fullImage.readAsBytes());

      Navigator.pop(context);
      widget.onImageTaken(image.path, image.path.split('/').last);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
