import 'dart:io';

import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsImagePreviewWidget extends StatelessWidget {
  final File imageFile;

  final VoidCallback? onRetake;
  final VoidCallback? onSave;

  const AgsImagePreviewWidget({
    super.key,
    required this.imageFile,
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
              child: Image.file(
                File(imageFile.path),
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
                    child: TextButton(
                      onPressed: () async {
                        onRetake?.call();
                      },
                      child: AgsText(
                        "Retake",
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        onSave?.call();
                      },
                      child: AgsText("Save"),
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
