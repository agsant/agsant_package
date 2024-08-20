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
    super.key,
    required this.title,
    required this.onTap,
    this.type = AgsButtonType.primary,
    this.color,
    this.textColor,
    this.textType,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (type == AgsButtonType.text) {
      child = AgsText(
        title,
        type: textType ?? AgsTextType.title,
        color: color,
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
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            color ?? AgsColor.blue60,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            color ?? AgsColor.blue60,
          ),
        );
      case AgsButtonType.primaryDanger:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            AgsColor.red,
          ),
        );
      case AgsButtonType.outline:
        return ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: color ?? AgsColor.blue60,
                width: 1,
              ),
            ),
          ),
        );
      case AgsButtonType.roundedButton:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            color ?? AgsColor.blue60,
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            color ?? AgsColor.white,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
