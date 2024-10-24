import 'dart:io';

import 'package:agsant_package/agsant_package.dart';
import 'package:agsant_package/src/camera/ags_camera_overlay.dart';
import 'package:agsant_package/src/camera/ags_image_preview_widget.dart';
import 'package:agsant_package/src/camera/file_helper.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class AgsCamera extends StatefulWidget {
  final bool isSquare;
  final void Function(String path)? onSave;

  const AgsCamera({
    super.key,
    this.onSave,
    this.isSquare = false,
  });

  @override
  State<AgsCamera> createState() => _AgsCameraState();
}

class _AgsCameraState extends State<AgsCamera> with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  File? _image;

  final BehaviorSubject<List<CameraDescription>?> _cameras =
      BehaviorSubject<List<CameraDescription>?>.seeded(null);

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    _cameras.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    File? imageFile = _image;
    if (imageFile != null) {
      return AgsImagePreviewWidget(
        imageFile: imageFile,
        onSave: () {
          String path = _image?.path ?? '';
          if (path.isNotEmpty) {
            widget.onSave?.call(path);
          } else {
            throw FlutterError('File not found');
          }
          Navigator.pop(context);
        },
        onRetake: () {
          setState(() {
            _image = null;
          });
        },
      );
    }

    return StreamBuilder(
      stream: _cameras,
      builder: (context, snapshot) {
        List<CameraDescription>? cmr = snapshot.data;
        if (cmr == null) {
          return _getLoadingView();
        } else if (cmr.isNotEmpty) {
          return _getCameraView();
        } else {
          throw FlutterError('Camera not available');
        }
      },
    );
  }

  Widget _getCameraView() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _isCameraPermissionGranted
            ? _isCameraInitialized
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / controller!.value.aspectRatio,
                        child: Stack(
                          children: [
                            _getCameraPreview(),
                            _getCaptureButton(),
                          ],
                        ),
                      ),
                    ],
                  )
                : _getLoadingView()
            : _getPermissionInfo(),
      ),
    );
  }

  Widget _getCameraPreview() {
    return Stack(
      children: [
        CameraPreview(
          controller!,
          child: LayoutBuilder(builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) => onViewFinderTap(details, constraints),
            );
          }),
        ),
        if (widget.isSquare)
          AgsCameraOverlay(
            padding: 0,
            color: AgsColor.black,
          ),
      ],
    );
  }

  Widget _getCaptureButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () async => _onTapCapture(),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.white38,
                  size: 80,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 65,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLoadingView() {
    return const Center(
      child: Text(
        'Loading...',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _getPermissionInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Permission denied, please allow the permission!',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            _checkPermission();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Give Permission',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
      throw FlutterError('Error initializing camera');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  _checkPermission() async {
    try {
      _cameras.emit(await availableCameras());
    } on CameraException catch (e) {
      debugPrint('Error in fetching the cameras: $e');
      throw FlutterError('Error in fetching the cameras');
    }

    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() {
        _isCameraPermissionGranted = true;
      });
      _onCameraSelected(_cameras.value![0]);
      // refreshAlreadyCapturedImages();
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  _onTapCapture() async {
    XFile? rawImage = await takePicture();
    File imageFile = File(rawImage!.path);

    String fileFormat = imageFile.path.split('.').last;

    if (widget.isSquare) {
      String base =
          '${(await getApplicationDocumentsDirectory()).path}/capture';
      Directory newDir = Directory(base);
      if (!(await newDir.exists())) {
        await newDir.create();
      }

      String path = '$base/capture_temp.$fileFormat';

      File? newFile = await FileHelper.cropSquare(imageFile.path, path, false);
      debugPrint(newFile?.path);

      if (newFile != null) {
        if (await imageFile.exists()) {
          await imageFile.delete();
        }
        imageFile = newFile;
      }
    }

    setState(() {
      _image = imageFile;
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }
}
