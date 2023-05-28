import 'package:agsant_package/src/custom_base_widget/network_image/services/resize_image_service.dart';
import 'package:agsant_package/src/custom_base_widget/network_image/storage/image_mapping_model.dart';
import 'package:agsant_package/src/custom_base_widget/network_image/storage/network_image_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

import 'image_service_param.dart';

class NetworkImageService {
  NetworkImageService._internal();
  static NetworkImageService shared = NetworkImageService._internal();

  Future<ImageProvider> streamImage(ImageServiceParam param) async {
    ImageProvider? imageProvider = await _getImage(param.url);

    if (imageProvider != null) {
      return imageProvider;
    } else {
      final ByteData imageData = await NetworkAssetBundle(
        Uri.parse(param.url),
      ).load(param.url).timeout(
            param.timeoutDuration ?? const Duration(minutes: 2),
          );

      Uint8List originalImageBytes = imageData.buffer.asUint8List();

      await _saveImageToCache(param, originalImageBytes);

      return MemoryImage(originalImageBytes);
    }
  }

  Future _saveImageToCache(
    ImageServiceParam param,
    Uint8List imageBytes,
  ) async {
    String extension =
        lookupMimeType('', headerBytes: imageBytes)?.split('/').last ?? 'jpg';
    String fileName = 'img_${DateTime.now().toString()}.$extension';

    Duration duration = param.cacheDuration ?? const Duration(days: 1);

    Uint8List? resizedBytes;
    if (param.cacheHeight != null || param.cacheWidth != null) {
      ResizeImageService resizeParam = ResizeImageService(
        imageBytes: imageBytes,
        cacheHeight: param.cacheHeight,
        cacheWidth: param.cacheWidth,
      );

      resizedBytes = await compute<int, Uint8List?>(
        resizeParam.resize,
        param.quality,
      );
    }

    NetworkImageStorage.shared.writeImage(
      model: ImageMappingModel(
        fileName: fileName,
        expiredDate: DateTime.now().add(duration),
        url: param.url,
        imageBytes: resizedBytes ?? imageBytes,
      ),
    );
  }

  /// get image from single url.
  /// this function will try to get from storage first.
  /// image cache will be used if it has not expired.
  /// if the cache has been expired, this function will trying
  /// to get the image from network
  Future<ImageProvider?> _getImage(String url) async {
    ImageMappingModel? model =
        await NetworkImageStorage.shared.readImage(url: url);

    if (model != null) {
      if (model.expiredDate.isAfter(DateTime.now())) {
        return MemoryImage(model.imageBytes);
      } else {
        await NetworkImageStorage.shared.removeItem(url: url);
      }
    }
    return null;
  }

  /// calling function to remove all image caches.
  Future removeAllCache() async {
    await NetworkImageStorage.shared.removeAll();
  }
}
