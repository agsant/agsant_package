import 'dart:io';
import 'dart:math';

import 'package:image/image.dart' as IMG;

class FileHelper {
  static Future<File?> cropSquare(
    String srcFilePath,
    String destFilePath,
    bool flip,
  ) async {
    var bytes = await File(srcFilePath).readAsBytes();
    IMG.Image? src = IMG.decodeImage(bytes);
    if (src != null) {
      var cropSize = min(src.width, src.height);
      int offsetX = (src.width - min(src.width, src.height)) ~/ 2;
      int offsetY = (src.height - min(src.width, src.height)) ~/ 2;
      print('height: ${src.height} ; width: ${src.width}');
      print('size: $cropSize - x: $offsetX - y: $offsetY');

      IMG.Image destImage = IMG.copyCrop(
        src,
        x: offsetX,
        y: offsetY,
        width: cropSize,
        height: cropSize,
      );

      if (flip) {
        destImage = IMG.flipVertical(destImage);
      }

      var jpg = IMG.encodeJpg(destImage);
      return File(destFilePath).writeAsBytes(jpg);
    }
    return null;
  }
}
