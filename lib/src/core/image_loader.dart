import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';

import 'load_manager.dart';

abstract class ImageLoader {
  ImageProvider get imageProvider;
  Future<void> loadImage();
  void dispose();
}

class AssetImageLoader extends ImageLoader {
  AssetImageLoader({
    required this.imageProvider,
  }) {
    _cacheManager = DefaultCacheManager();
    _loadManager = LoadManager(cacheManager: _cacheManager);
  }

  @override
  final AssetImage imageProvider;
  late final LoadManager _loadManager;
  late final DefaultCacheManager _cacheManager;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadAssetImage(assetPath: imageProvider.assetName);
  }

  @override
  void dispose() {
    _cacheManager.dispose();
  }
}

class FileImageLoader extends ImageLoader {
  FileImageLoader({
    required this.imageProvider,
  }) {
    _cacheManager = DefaultCacheManager();
    _loadManager = LoadManager(cacheManager: _cacheManager);
  }

  @override
  final FileImage imageProvider;
  late final LoadManager _loadManager;
  late final DefaultCacheManager _cacheManager;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadCachedFileImage(imageFile: imageProvider.file);
  }

  @override
  void dispose() {
    _cacheManager.dispose();
  }
}

class MemoryImageLoader extends ImageLoader {
  MemoryImageLoader({
    required this.imageProvider,
  }) {
    _cacheManager = DefaultCacheManager();
    _loadManager = LoadManager(cacheManager: _cacheManager);
  }

  @override
  final MemoryImage imageProvider;
  late final LoadManager _loadManager;
  late final DefaultCacheManager _cacheManager;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadCachedMemoryImage(imageBytes: imageProvider.bytes);
  }

  @override
  void dispose() {
    _cacheManager.dispose();
  }
}
