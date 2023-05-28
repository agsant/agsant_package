import 'dart:typed_data';

class ImageMappingModel {
  late String fileName;
  late DateTime expiredDate;
  late String url;
  late Uint8List imageBytes;

  ImageMappingModel({
    required this.fileName,
    required this.expiredDate,
    required this.url,
    required this.imageBytes,
  });

  Map<String, dynamic> getMap() {
    return {
      'fileName': fileName,
      'expiredDate': expiredDate.microsecondsSinceEpoch,
    };
  }

  ImageMappingModel.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    expiredDate = DateTime.fromMicrosecondsSinceEpoch(json['expiredDate']);
  }
}
