import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback? onTapCapture;

  const CaptureButton({super.key, this.onTapCapture});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: onTapCapture,
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
}
