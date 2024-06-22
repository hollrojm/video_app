import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecorder extends StatefulWidget {
  const VideoRecorder({super.key});

  @override
  State<VideoRecorder> createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isRecording ? Icons.stop : Icons.videocam),
        onPressed: () async {
          if (_isRecording) {
            final file = await _cameraController.stopVideoRecording();
            setState(() => _isRecording = false);
            Navigator.of(context).pop(file.path);
          } else {
            await _cameraController.startVideoRecording();
            setState(() => _isRecording = true);
          }
        },
      ),
    );
  }
}
