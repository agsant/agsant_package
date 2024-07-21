import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgsTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final int? maxLength;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final FocusNode? focusNode;

  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const AgsTextField({
    super.key,
    required this.title,
    this.onChanged,
    this.controller,
    this.maxLength,
    this.inputType,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.initialValue,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AgsText(
            title,
            textStyle: const TextStyle(height: 1),
          ),
          TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            controller: controller,
            keyboardType: inputType,
            maxLength: maxLength,
            onChanged: onChanged,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              isDense: true,
            ),
            inputFormatters: inputFormatters,
            initialValue: initialValue,
            focusNode: focusNode,
          ),
        ],
      ),
    );
  }
}
