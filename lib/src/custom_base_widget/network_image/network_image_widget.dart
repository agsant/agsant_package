import 'package:agsant_package/src/custom_base_widget/network_image/services/image_service_param.dart';
import 'package:agsant_package/src/custom_base_widget/network_image/services/network_image_service.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatefulWidget {
  final String source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget Function(
    BuildContext context,
    Object? error,
  )? onError;
  final Widget Function(BuildContext context)? onLoading;
  final Color? color;
  final Duration? timeoutDuration;
  final Duration? cacheDuration;
  final int? cacheWidth;
  final int? cacheHeight;

  const NetworkImageWidget(
    this.source, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onError,
    this.onLoading,
    this.color,
    this.cacheDuration,
    this.timeoutDuration,
    this.cacheHeight,
    this.cacheWidth,
  }) : super(key: key);

  @override
  NetworkImageWidgetState createState() => NetworkImageWidgetState();
}

class NetworkImageWidgetState extends State<NetworkImageWidget>
    with TickerProviderStateMixin {
  ImageProvider? _imageProvider;
  bool isError = false;
  Object? errorMessage;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    streamImage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return _errorWidget();
    }

    ImageProvider? provider = _imageProvider;
    if (provider == null) {
      return _loadingWidget();
    }

    _controller.forward();
    return Image(
      image: provider,
      opacity: _animation,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      color: widget.color,
    );
  }

  Future streamImage() async {
    try {
      ImageProvider imageProvider =
          await NetworkImageService.shared.streamImage(
        ImageServiceParam(
          url: widget.source,
          timeoutDuration: widget.timeoutDuration,
          cacheDuration: widget.cacheDuration,
          cacheWidth: widget.cacheWidth,
          cacheHeight: widget.cacheHeight,
        ),
      );

      if (!mounted) {
        return;
      }
      setState(() {
        _imageProvider = imageProvider;
      });
    } catch (e) {
      debugPrint('stream image error: $e');
      if (!mounted) {
        return;
      }
      setState(() {
        errorMessage = e;
        isError = true;
      });
    }
  }

  Widget _errorWidget() {
    Widget Function(
      BuildContext context,
      Object? error,
    )? callback = widget.onError;

    if (callback != null) {
      return callback(context, errorMessage);
    }

    return const SizedBox.shrink();
  }

  Widget _loadingWidget() {
    Widget Function(BuildContext context)? callback = widget.onLoading;

    if (callback != null) {
      return callback(context);
    }

    return const SizedBox.shrink();
  }
}
