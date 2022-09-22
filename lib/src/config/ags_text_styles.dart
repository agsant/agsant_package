import 'package:agsant_package/src/consts/ags_colors.dart';
import 'package:agsant_package/src/enums/ags_text_type.dart';
import 'package:flutter/cupertino.dart';

TextStyle getTextStyleBaseOnType(
  AgsTextType type,
  Color? color,
  bool underline,
) {
  TextStyle _customStyle = TextStyle(
    color: color ?? AgsColor.black,
    decoration: underline ? TextDecoration.underline : null,
  );

  switch (type) {
    case AgsTextType.title:
      return const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
          .merge(_customStyle);
    case AgsTextType.titleSemiBold:
      return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
          .merge(_customStyle);
    case AgsTextType.titleBold:
      return const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
          .merge(_customStyle);
    case AgsTextType.normal:
      return const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
          .merge(_customStyle);
    case AgsTextType.normalBold:
      return const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)
          .merge(_customStyle);
    case AgsTextType.caption:
      return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)
          .merge(_customStyle);
    case AgsTextType.captionBold:
      return const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)
          .merge(_customStyle);
  }
}
