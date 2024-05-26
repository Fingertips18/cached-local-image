import 'dart:async';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LoadManager {
  LoadManager({
    required DefaultCacheManager cacheManager,
    Duration? duration,
  }) {
    _cacheManager = cacheManager;
    _duration = duration;
  }

  late final DefaultCacheManager _cacheManager;
  late final Duration? _duration;

  Future<void> _loadImage({required ImageProvider imageProvider}) async {
    final Completer<void> completer = Completer<void>();
    final ImageStream imageStream = imageProvider.resolve(const ImageConfiguration());
    final ImageStreamListener imageListener = ImageStreamListener((ImageInfo info, bool synchronousCall) => completer.complete());

    await Future.delayed(_duration ?? Duration.zero);

    imageStream.addListener(imageListener);
    await completer.future;
    imageStream.removeListener(imageListener);
  }

  Future<void> loadAssetImage({required String assetPath}) async {
    late final File cachedFile;

    try {
      cachedFile = await _cacheManager.getSingleFile(assetPath);
    } catch (_) {
      cachedFile = await _cacheAssetImage(assetPath: assetPath);
    }

    await _loadImage(imageProvider: FileImage(cachedFile));
  }

  Future<void> loadCachedFileImage({required File imageFile}) async {
    late final File cachedFile;

    try {
      cachedFile = await _cacheManager.getSingleFile(imageFile.path);
    } catch (_) {
      cachedFile = await _cacheFileImage(imageFile: imageFile);
    }

    await _loadImage(imageProvider: FileImage(cachedFile));
  }

  Future<void> loadCachedMemoryImage({required Uint8List imageBytes}) async {
    final key = imageBytes.hashCode.toString();

    late final File cachedFile;

    try {
      cachedFile = await _cacheManager.getSingleFile(key);
    } catch (_) {
      cachedFile = await _cachedImageBytes(imageBytes: imageBytes);
    }

    await _loadImage(imageProvider: FileImage(cachedFile));
  }

  Future<File> _cacheAssetImage({required String assetPath}) async {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();
    final cachedFile = await _cacheManager.putFile(assetPath, bytes);
    return cachedFile;
  }

  Future<File> _cacheFileImage({required File imageFile}) async {
    final fileBytes = await imageFile.readAsBytes();
    final cachedFile = await _cacheManager.putFile(imageFile.path, fileBytes);
    return cachedFile;
  }

  Future<File> _cachedImageBytes({required Uint8List imageBytes}) async {
    final key = imageBytes.hashCode.toString();
    final cachedFile = await _cacheManager.putFile(key, imageBytes);
    return cachedFile;
  }
}
