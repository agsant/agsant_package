import 'package:flutter/material.dart';

class AgsCheckbox extends StatelessWidget {
  final bool value;
  final bool readOnly;
  final double size;
  final void Function(bool)? onChanged;

  const AgsCheckbox({
    super.key,
    this.value = false,
    this.readOnly = false,
    this.size = 24,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
