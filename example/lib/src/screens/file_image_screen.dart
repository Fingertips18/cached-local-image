import 'dart:io';

import 'package:load_local_image/load_local_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/dimensions.dart';
import '../constants/assets.dart';

class FileImageScreen extends StatefulWidget {
  const FileImageScreen({super.key});

  @override
  State<FileImageScreen> createState() => _FileImageScreenState();
}

class _FileImageScreenState extends State<FileImageScreen> with WidgetsBindingObserver {
  late final Future<File> _future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _getImageFile();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _removeImageFile();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<File> _getImageFile() async {
    final dir = (await getTemporaryDirectory()).path;
    File file = File("$dir/image");

    if (await file.exists()) {
      return file;
    }

    file = await File("$dir/image").create();
    final bytes = await rootBundle.load(image_2);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file;
  }

  void _removeImageFile() async {
    final dir = (await getTemporaryDirectory()).path;
    final file = File("$dir/image");

    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "File Image",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Without Load Local Image",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      const SizedBox(height: spacing),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(kRadialReactionRadius),
                          ),
                        ),
                      ),
                      const SizedBox(height: bigSpacing),
                      const Text(
                        "With Load Local Image",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      const SizedBox(height: spacing),
                      Expanded(
                        child: LoadLocalImage(
                          imageLoader: FileImageLoader(imageProvider: FileImage(snapshot.data!)),
                          placeholder: const Center(
                            child: CircularProgressIndicator(color: Colors.black),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(snapshot.data!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(kRadialReactionRadius),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text("No file image"));
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Fetching file image..."));
              } else {
                return const Center(child: Text("Error fetching file image"));
              }
            },
          ),
        ),
      ),
    );
  }
}
