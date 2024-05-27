import 'package:flutter/material.dart';

import 'load_manager.dart';

abstract class ImageLoader {
  ImageProvider get imageProvider;
  Future<void> loadImage();
}

class AssetImageLoader extends ImageLoader {
  AssetImageLoader({
    required this.imageProvider,
    Duration? delay,
  }) : _loadManager = LoadManager(delay: delay);

  @override
  final AssetImage imageProvider;
  late final LoadManager _loadManager;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadImage(imageProvider: imageProvider);
  }
}

class FileImageLoader extends ImageLoader {
  FileImageLoader({
    required this.imageProvider,
    Duration? delay,
  }) : _loadManager = LoadManager(delay: delay);

  @override
  final FileImage imageProvider;
  late final LoadManager _loadManager;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadImage(imageProvider: imageProvider);
  }
}

class MemoryImageLoader extends ImageLoader {
  MemoryImageLoader({
    required this.imageProvider,
    Duration? delay,
  }) : _loadManager = LoadManager(delay: delay);

  @override
  final MemoryImage imageProvider;
  late final LoadManager _loadManager;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadImage(imageProvider: imageProvider);
  }
}
