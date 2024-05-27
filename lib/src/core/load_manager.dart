import 'dart:async';

import 'package:flutter/material.dart';

class LoadManager {
  LoadManager({Duration? delay}) : _duration = delay;

  late final Duration? _duration;

  Future<void> loadImage({required ImageProvider imageProvider}) async {
    final Completer<void> completer = Completer<void>();
    final ImageStream imageStream = imageProvider.resolve(const ImageConfiguration());
    final ImageStreamListener imageListener = ImageStreamListener((ImageInfo info, bool synchronousCall) => completer.complete());

    await Future.delayed(_duration ?? Duration.zero);

    imageStream.addListener(imageListener);
    await completer.future;
    imageStream.removeListener(imageListener);
  }
}
