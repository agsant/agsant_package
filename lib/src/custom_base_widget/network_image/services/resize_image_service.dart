import 'dart:typed_data';
import 'package:image/image.dart' as image;

class ResizeImageService {
  final Uint8List imageBytes;
  final int? cacheWidth;
  final int? cacheHeight;

  ResizeImageService({
    required this.imageBytes,
    this.cacheWidth,
    this.cacheHeight,
  });

  Future<Uint8List?> resize(int quality) async {
    image.Image? imageFile = image.decodeImage(imageBytes);
    if (imageFile != null) {
      image.Image resizeImage = image.copyResize(
        imageFile,
        width: cacheWidth,
        height: cacheHeight,
      );
      final Uint8List resizedBytes = image.encodePng(
        resizeImage,
      );
      return resizedBytes;
    }
    return null;
  }
}
