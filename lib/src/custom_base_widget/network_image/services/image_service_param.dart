class ImageServiceParam {
  final String url;
  final Duration? timeoutDuration;
  final Duration? cacheDuration;
  final int? cacheWidth;
  final int? cacheHeight;
  final int quality;

  ImageServiceParam({
    required this.url,
    this.timeoutDuration,
    this.cacheDuration,
    this.cacheWidth,
    this.cacheHeight,
    this.quality = 100,
  });
}
