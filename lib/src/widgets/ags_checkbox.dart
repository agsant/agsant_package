import 'package:flutter/material.dart';

class AgsCheckbox extends StatelessWidget {
  final bool value;
  final bool readOnly;
  final void Function(bool)? onChanged;
  final VoidCallback? onTap;

  const AgsCheckbox({
    super.key,
    this.value = false,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Checkbox(
        value: value,
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
