import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  Future<void> _takePicture() async {
    final image = await _controller!.takePicture();
    _showSuggestions(image);
  }

  void _showSuggestions(XFile image) {
    // Analyze the image and fetch suggestions
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: ListView(
            children: [
              ListTile(title: Text("Recipe 1 - 90%")),
              ListTile(title: Text("Recipe 2 - 75%")),
              // Add more suggestions
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                CameraPreview(_controller!),
                Center(
                  child: ElevatedButton(
                    onPressed: _takePicture,
                    child: Text("Capture"),
                  ),
                ),
              ],
            ),
    );
  }
}
