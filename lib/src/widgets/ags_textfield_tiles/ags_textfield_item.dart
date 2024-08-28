import 'dart:async';

import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgsTextfieldItem extends StatefulWidget {
  final bool isChecklistType;
  final bool showCheckbox;
  final bool requestFocus;
  final AgsTextFieldItemModel? param;
  final int index;

  final void Function(bool checked, String value)? onChanged;
  final VoidCallback? onEnter;
  final void Function(int)? onRemove;
  final VoidCallback? onGetFocus;

  const AgsTextfieldItem({
    super.key,
    required this.isChecklistType,
    required this.showCheckbox,
    required this.requestFocus,
    required this.index,
    this.param,
    this.onEnter,
    this.onChanged,
    this.onRemove,
    this.onGetFocus,
  });

  @override
  State<StatefulWidget> createState() => _AgsTextfieldItemState();
}

class _AgsTextfieldItemState extends State<AgsTextfieldItem> {
  final TextEditingController _controller = TextEditingController();
  late final FocusNode _focusNode;

  Timer? _debounce;

  bool _checked = false;
  final int keyBackspace = 0x100000008;
  final String keyBackspaceLabel = 'Backspace';

  @override
  void initState() {
    super.initState();

    if (widget.param != null) {
      _controller.text = widget.param?.text ?? '';
      _checked = widget.param?.checked ?? false;
    }

    _controller.addListener(_onTextChanged);
    _focusNode = FocusNode(
      onKeyEvent: (node, event) {
        if (_controller.text.isEmpty &&
            event is KeyDownEvent &&
            (event.logicalKey.keyId == keyBackspace ||
                event.logicalKey.keyLabel == keyBackspaceLabel)) {
          widget.onRemove?.call(widget.index);
        }
        return KeyEventResult.ignored;
      },
    );
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onGetFocus?.call();
      }
    });

    if (widget.requestFocus || _focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.isChecklistType && widget.showCheckbox)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AgsCheckbox(
              value: _checked,
              onChanged: (value) {
                setState(() {
                  _checked = value;
                });
                widget.onChanged?.call(_checked, _controller.text);
              },
            ),
          ),
        Expanded(
          child: TextField(
            focusNode: _focusNode,
            minLines: 1,
            maxLines: 200,
            textCapitalization: TextCapitalization.sentences,
            controller: _controller,
            style: const TextStyle(height: 1),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 8),
            ),
            onChanged: (value) {
              if (widget.isChecklistType) {
                if (value.contains('\n')) {
                  String text = value.replaceAll('\n', '');
                  _controller.text = text;
                  widget.onEnter?.call();
                }
              }
            },
          ),
        ),
      ],
    );
  }

  _onTextChanged() {
    Timer? timer = _debounce;
    if (timer != null && timer.isActive) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged?.call(_checked, _controller.text);
    });
  }
}
