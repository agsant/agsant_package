import 'dart:async';

import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsTextfieldItem extends StatefulWidget {
  final bool isChecklistType;
  final bool showCheckbox;

  final void Function(bool checked, String value)? onChanged;
  final VoidCallback? onEnter;

  const AgsTextfieldItem({
    super.key,
    required this.isChecklistType,
    required this.showCheckbox,
    this.onEnter,
    this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _AgsTextfieldItemState();
}

class _AgsTextfieldItemState extends State<AgsTextfieldItem> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Timer? _debounce;

  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      minLines: 1,
      maxLines: 200,
      controller: _controller,
      decoration: (widget.isChecklistType && widget.showCheckbox)
          ? InputDecoration(
              prefixIcon: AgsCheckbox(
                value: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = value;
                  });
                  widget.onChanged?.call(_checked, _controller.text);
                },
              ),
            )
          : const InputDecoration(),
      onChanged: (value) {
        if (widget.isChecklistType) {
          if (value.contains('\n')) {
            String text = value.replaceAll('\n', '');
            _controller.text = text;
            widget.onEnter?.call();
          }
        }
      },
    );
  }

  _onSearchChanged() {
    Timer? _timer = _debounce;
    if (_timer != null && _timer.isActive) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      widget.onChanged?.call(_checked, _controller.text);
    });
  }
}
