import 'package:flutter/material.dart';

import 'core/image_loader.dart';

class LoadLocalImageWidget extends StatefulWidget {
  const LoadLocalImageWidget({
    super.key,
    required this.imageLoader,
    this.placeholder,
    this.errorWidget,
  });

  final ImageLoader imageLoader;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  State<LoadLocalImageWidget> createState() => _LoadLocalImageWidgetState();
}

class _LoadLocalImageWidgetState extends State<LoadLocalImageWidget> {
  @override
  void dispose() {
    widget.imageLoader.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.imageLoader.loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.placeholder ?? const SizedBox.shrink();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return widget.imageLoader.imageProvider as Widget;
        } else {
          return widget.errorWidget ?? const SizedBox.shrink();
        }
      },
    );
  }
}
