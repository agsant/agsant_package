import 'package:agsant_package/src/consts/ags_image_assets.dart';
import 'package:agsant_package/src/enums/ags_image_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgsImage extends StatelessWidget {
  final String source;
  final AgsImageType type;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? placeholderImage;
  final double? cornerRadius;

  const AgsImage(
    this.source, {
    Key? key,
    required this.type,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.placeholderImage,
    this.cornerRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AgsImageType.network:
        return _getNetworkImage();
      case AgsImageType.asset:
        return _getImageAsset();
      case AgsImageType.svgAsset:
        return _getSVGAsset();
    }
  }

  Widget _getNetworkImage() {
    Widget image = CachedNetworkImage(
      imageUrl: source,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, error) => SvgPicture.asset(
        placeholderImage ?? AgsImageAssets.placeholderImage,
      ),
    );
    if (cornerRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRadius ?? 0),
        ),
        child: image,
      );
    }
    return image;
  }

  Widget _getImageAsset() {
    Widget image = Image.asset(
      source,
      width: width,
      height: height,
      fit: fit,
    );
    if (cornerRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRadius ?? 0),
        ),
        child: image,
      );
    }
    return image;
  }

  Widget _getSVGAsset() {
    Widget image = SvgPicture.asset(
      source,
      width: width,
      height: height,
      fit: fit,
    );

    if (cornerRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRadius ?? 0),
        ),
        child: image,
      );
    }
    return image;
  }
}
