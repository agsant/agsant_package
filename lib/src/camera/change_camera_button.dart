import 'package:flutter/material.dart';

class ChangeCameraButton extends StatelessWidget {
  final VoidCallback? onTapChange;

  const ChangeCameraButton({super.key, this.onTapChange});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 16),
          child: GestureDetector(
            onTap: onTapChange,
            child: const Icon(
              Icons.change_circle,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}
