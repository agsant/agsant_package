import 'package:agsant_package/agsant_package.dart';
import 'package:flutter/material.dart';

class AgsButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final AgsButtonType type;
  final Color? textColor;
  final Color? color;
  final AgsTextType? textType;
  final double borderRadius;

  const AgsButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.type = AgsButtonType.primary,
    this.color,
    this.textColor,
    this.textType,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (type == AgsButtonType.text) {
      child = AgsText(
        title,
        type: textType ?? AgsTextType.title,
        color: color ?? AgsColor.blue60,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      child = Center(
        child: IntrinsicWidth(
          child: AgsText(
            title,
            type: textType ?? AgsTextType.title,
            color: _getColor(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return TextButton(
      onPressed: onTap,
      style: _getButtonStyle(),
      child: child,
    );
  }

  ButtonStyle? _getButtonStyle() {
    switch (type) {
      case AgsButtonType.primary:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? AgsColor.blue60,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            color ?? AgsColor.blue60,
          ),
        );
      case AgsButtonType.primaryDanger:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            AgsColor.red,
          ),
        );
      case AgsButtonType.outline:
        return ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(
                color: color ?? AgsColor.blue60,
                width: 1,
              ),
            ),
          ),
        );
      case AgsButtonType.roundedButton:
        return ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? AgsColor.blue60,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            color ?? AgsColor.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        );
      case AgsButtonType.text:
        return null;
    }
  }

  Color _getColor() {
    switch (type) {
      case AgsButtonType.primary:
        return AgsColor.white;
      case AgsButtonType.primaryDanger:
        return AgsColor.white;
      case AgsButtonType.outline:
        return color ?? AgsColor.blue60;
      case AgsButtonType.text:
        return color ?? AgsColor.blue60;
      case AgsButtonType.roundedButton:
        return AgsColor.white;
    }
  }
}
