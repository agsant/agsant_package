import 'package:flutter/material.dart';

class AgsCheckbox extends StatelessWidget {
  final bool value;
  final bool readOnly;
  final double size;
  final void Function(bool)? onChanged;
  final VoidCallback? onTap;

  const AgsCheckbox({
    super.key,
    this.value = false,
    this.readOnly = false,
    this.size = 24,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size,
        width: size,
        child: Checkbox(
          value: value,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (result) {
            if (readOnly) {
              return;
            }
            onChanged?.call(result ?? false);
          },
        ),
      ),
    );
  }
}
