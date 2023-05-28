import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'image_mapping_model.dart';

class NetworkImageStorage {
  String _temporaryDirectory = '';
  Map<String, dynamic> mapData = {};

  NetworkImageStorage._internal();

  static NetworkImageStorage shared = NetworkImageStorage._internal();

  /// get temporary directory
  Future<String> _getCachePath() async {
    if (_temporaryDirectory.isEmpty) {
      _temporaryDirectory =
          '${(await getTemporaryDirectory()).path}/customNetworkImage';
    }
    Directory directory = Directory(_temporaryDirectory);
    if (!await directory.exists()) {
      await directory.create();
    }
    return _temporaryDirectory;
  }

  /// get path of cache file
  Future<String> _mappingFilePath() async {
    return '${await _getCachePath()}/mapping_image_cache.json';
  }

  /// read content of cache file.
  /// content may empty, so this will returning empty map object as a default.
  Future _readFileContent() async {
    try {
      String filePath = await _mappingFilePath();
      File cacheFile = File(filePath);
      if (await cacheFile.exists()) {
        final String data = await cacheFile.readAsString();
        mapData = jsonDecode(data);

        if (mapData.isEmpty) {
          await removeAll();
        }
      }
    } catch (e) {
      debugPrint('_readFileContent-error: $e');
      await removeAll();
    }
  }

  Future writeImage({
    required ImageMappingModel model,
  }) async {
    String filePath = '${await _getCachePath()}/${model.fileName}';

    File imageFile = File(filePath);

    await imageFile.writeAsBytes(model.imageBytes);

    String imageData = jsonEncode(model.getMap());
    mapData[model.url] = imageData;

    await updateMappingFile();
  }

  Future<ImageMappingModel?> readImage({required String url}) async {
    if (mapData.isEmpty) {
      await _readFileContent();
    }

    String imageData = mapData[url] ?? '';
    if (imageData.isNotEmpty) {
      ImageMappingModel model = ImageMappingModel.fromJson(
        jsonDecode(imageData),
      );

      File imageFile = File('${await _getCachePath()}/${model.fileName}');
      if (await imageFile.exists()) {
        Uint8List imageBytes = await imageFile.readAsBytes();
        return ImageMappingModel(
          fileName: model.fileName,
          expiredDate: model.expiredDate,
          url: url,
          imageBytes: imageBytes,
        );
      }
    }
    return null;
  }

  /// removing single cache by key.
  Future removeItem({required String url}) async {
    if (mapData.isEmpty) {
      await _readFileContent();
    }

    String imageData = mapData[url] ?? '';
    if (imageData.isNotEmpty) {
      ImageMappingModel model = ImageMappingModel.fromJson(
        jsonDecode(imageData),
      );

      File file = File('${await _getCachePath()}/${model.fileName}');
      if (await file.exists()) {
        await file.delete();
      }

      mapData.remove(url);
      await updateMappingFile();
    }
  }

  Future updateMappingFile() async {
    File mappingFile = File(await _mappingFilePath());
    await mappingFile.writeAsString(jsonEncode(mapData));
  }

  // /// removing all caches
  Future removeAll() async {
    Directory directory = Directory(await _getCachePath());
    if (await directory.exists()) {
      return directory.delete(recursive: true);
    }
  }
}
