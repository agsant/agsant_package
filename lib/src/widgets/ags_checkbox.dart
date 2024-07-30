import 'package:flutter/material.dart';

class AgsCheckbox extends StatelessWidget {
  final bool value;
  final bool readOnly;
  final void Function(bool)? onChanged;

  const AgsCheckbox({
    super.key,
    this.value = false,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (result) {
        if (readOnly) {
          return;
        }
        onChanged?.call(result ?? false);
      },
    );
  }
}
