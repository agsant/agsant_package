import 'dart:async';

import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsTextArea extends StatefulWidget {
  final int maxLength;
  final String text;
  final bool showCounter;

  const AgsTextArea({
    super.key,
    this.maxLength = 120,
    this.text = '',
    this.showCounter = true,
  });

  @override
  State<StatefulWidget> createState() => _AgsTextAreaState();
}

class _AgsTextAreaState extends State<AgsTextArea> {
  late final TextEditingController _controller;
  int counter = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.text.isNotEmpty) {
      _controller.text = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AgsColor.black),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 60),
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(4),
                border: InputBorder.none,
                counterText: '',
              ),
              minLines: 3,
              maxLines: 10,
              maxLength: widget.maxLength,
              onChanged: (text) {
                if (_timer?.isActive ?? false) _timer?.cancel();
                _timer = Timer(const Duration(milliseconds: 250), () {
                  setState(() {
                    counter = text.length;
                  });
                });
              },
              controller: _controller,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        _getCounter(),
      ],
    );
  }

  Widget _getCounter() {
    if (!widget.showCounter) {
      return const SizedBox.shrink();
    }

    Color counterColor = AgsColor.black;

    if ((widget.maxLength - counter) < 3 && counter > 0) {
      counterColor = AgsColor.orange;
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: counter.toString(),
            style: TextStyle(
              color: counterColor,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: '/${widget.maxLength}',
            style: const TextStyle(
              color: AgsColor.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
