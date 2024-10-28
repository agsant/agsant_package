import 'dart:io';

import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsImagePreviewWidget extends StatelessWidget {
  final File imageFile;
  final String? saveButton;
  final String? retakeButton;

  final VoidCallback? onRetake;
  final VoidCallback? onSave;

  const AgsImagePreviewWidget({
    super.key,
    required this.imageFile,
    this.saveButton,
    this.retakeButton,
    this.onSave,
    this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.memory(
                File(imageFile.path).readAsBytesSync(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onRetake?.call();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AgsText(
                            retakeButton ?? 'Retake',
                            color: AgsColor.white,
                            textStyle: TextStyle(
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        onSave?.call();
                      },
                      child: AgsText(
                        saveButton ?? 'Save',
                        color: AgsColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
