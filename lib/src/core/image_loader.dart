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
    required AssetImage assetImage,
  }) {
    _assetImage = assetImage;
    _cacheManager = DefaultCacheManager();
    _loadManager = LoadManager(cacheManager: _cacheManager);
  }

  late final AssetImage _assetImage;
  late final LoadManager _loadManager;
  late final DefaultCacheManager _cacheManager;

  @override
  AssetImage get imageProvider => _assetImage;

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
    required FileImage fileImage,
  }) {
    _fileImage = fileImage;
    _cacheManager = DefaultCacheManager();
    _loadManager = LoadManager(cacheManager: _cacheManager);
  }

  late final FileImage _fileImage;
  late final LoadManager _loadManager;
  late final DefaultCacheManager _cacheManager;

  @override
  FileImage get imageProvider => _fileImage;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadCachedFileImage(imageFile: _fileImage.file);
  }

  @override
  void dispose() {
    _cacheManager.dispose();
  }
}

class MemoryImageLoader extends ImageLoader {
  MemoryImageLoader({
    required MemoryImage memoryImage,
  }) {
    _memoryImage = memoryImage;
    _cacheManager = DefaultCacheManager();
    _loadManager = LoadManager(cacheManager: _cacheManager);
  }

  late final MemoryImage _memoryImage;
  late final LoadManager _loadManager;
  late final DefaultCacheManager _cacheManager;

  @override
  MemoryImage get imageProvider => _memoryImage;

  @override
  Future<void> loadImage() async {
    return await _loadManager.loadCachedMemoryImage(imageBytes: _memoryImage.bytes);
  }

  @override
  void dispose() {
    _cacheManager.dispose();
  }
}
