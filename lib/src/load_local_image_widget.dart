import 'package:flutter/material.dart';

import 'core/image_loader.dart';

class LoadLocalImage extends StatefulWidget {
  const LoadLocalImage({
    super.key,
    required this.imageLoader,
    this.placeholder,
    this.errorWidget,
    required this.child,
  });

  final ImageLoader imageLoader;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Widget child;

  @override
  State<LoadLocalImage> createState() => _LoadLocalImageState();
}

class _LoadLocalImageState extends State<LoadLocalImage> {
  @override
  void dispose() {
    widget.imageLoader.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.imageLoader.loadImage(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.placeholder ?? const SizedBox.shrink();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return widget.child;
        } else {
          return widget.errorWidget ?? const SizedBox.shrink();
        }
      },
    );
  }
}
