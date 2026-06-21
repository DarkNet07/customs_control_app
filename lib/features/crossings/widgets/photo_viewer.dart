import 'dart:io';

import 'package:flutter/material.dart';

/// Full-screen, zoomable, swipeable viewer for attached photos.
class PhotoViewerScreen extends StatefulWidget {
  const PhotoViewerScreen({
    super.key,
    required this.paths,
    this.initialIndex = 0,
  });

  final List<String> paths;
  final int initialIndex;

  static Future<void> open(
    BuildContext context,
    List<String> paths,
    int initialIndex,
  ) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) =>
            PhotoViewerScreen(paths: paths, initialIndex: initialIndex),
      ),
    );
  }

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_index + 1} / ${widget.paths.length}'),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.paths.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (_, i) {
          final file = File(widget.paths[i]);
          return InteractiveViewer(
            minScale: 1,
            maxScale: 5,
            child: Center(
              child: file.existsSync()
                  ? Image.file(file, fit: BoxFit.contain)
                  : const Icon(Icons.broken_image,
                      color: Colors.white54, size: 64),
            ),
          );
        },
      ),
    );
  }
}
