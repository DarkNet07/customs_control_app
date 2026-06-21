import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// A compressed photo plus its thumbnail, both stored in app documents.
typedef StoredPhoto = ({String filePath, String thumbPath});

/// Captures/picks images and compresses them to save storage.
class ImageService {
  ImageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;
  final _uuid = const Uuid();

  Future<Directory> _photosDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, 'photos'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<StoredPhoto?> captureFromCamera() async {
    final shot = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 2400,
      imageQuality: 90,
    );
    if (shot == null) return null;
    return _process(shot.path);
  }

  Future<List<StoredPhoto>> pickFromGallery() async {
    final shots = await _picker.pickMultiImage(maxWidth: 2400, imageQuality: 90);
    final result = <StoredPhoto>[];
    for (final s in shots) {
      final stored = await _process(s.path);
      if (stored != null) result.add(stored);
    }
    return result;
  }

  /// Compress to a full-size (~1600px, q70) JPEG and a small thumbnail.
  Future<StoredPhoto?> _process(String sourcePath) async {
    final dir = await _photosDir();
    final id = _uuid.v4();
    final fullPath = p.join(dir.path, '$id.jpg');
    final thumbPath = p.join(dir.path, '${id}_thumb.jpg');

    final full = await FlutterImageCompress.compressAndGetFile(
      sourcePath,
      fullPath,
      quality: 70,
      minWidth: 1600,
      minHeight: 1600,
      keepExif: false,
    );
    final thumb = await FlutterImageCompress.compressAndGetFile(
      sourcePath,
      thumbPath,
      quality: 60,
      minWidth: 300,
      minHeight: 300,
    );
    if (full == null || thumb == null) return null;
    return (filePath: full.path, thumbPath: thumb.path);
  }

  /// Removes the underlying files for a photo (used when discarding).
  Future<void> deleteFiles(String filePath, String thumbPath) async {
    for (final path in [filePath, thumbPath]) {
      final f = File(path);
      if (await f.exists()) await f.delete();
    }
  }
}
