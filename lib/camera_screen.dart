import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mycamera/body.dart';


class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List? cameras;
  late int selectedCameraIdx;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    // 1
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.length > 0) {
        setState(() {
          // 2
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras![selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      // 3
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  // 1, 2
  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    // 3
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // 4
    controller!.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller!.initialize();
    } on CameraException catch (e) {}

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: CameraPreview(controller!),
    );
  }

  void _onSwitchCamera() {
    selectedCameraIdx = selectedCameraIdx < cameras!.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras![selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Camera"), IconButton(onPressed: _onSwitchCamera, icon: Icon(Icons.cameraswitch))],
        ),
      ),
      body: Stack(
        children: [
          Container(height: 1200, child: _cameraPreviewWidget()),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.blueAccent,
              onPressed: () async {
                try {
                  // 1
                  final image = await controller!.takePicture();
                  // 2
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Body(
                        imagePath: image.path,
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: Icon(
                Icons.camera,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
