import '../api/models/word.dart';
import 'shared_preferences_service.dart';

/// Resolves a [Word]'s stored [imagePath] to a full Firebase Storage path.
///
/// Core vocabulary words store only a filename (e.g. `bowl.png`). The active
/// album is an app-level setting, so switching albums updates every word at
/// once without touching word data.
///
/// User-added words store a full path directly and are never album-switched.
///
/// Firebase Storage layout:
///   Core:  simple_aac/images/{album}/{filename}   e.g. simple_aac/images/core/bowl.png
///   User:  users/{userId}/images/{filename}
class ImagePathService {
  static const _coreBase = 'simple_aac/images';

  /// The album name used for the bundled line-drawing vocabulary.
  static const defaultAlbum = 'core';

  ImagePathService(this._prefs);

  final SharedPreferencesService _prefs;

  String get selectedAlbum => _prefs.imageAlbum;

  /// Returns the resolved Firebase Storage path for [word], or null if the
  /// word has no image.
  ///
  /// A bare filename (no slashes, not a URL) means the word is part of the
  /// bundled vocabulary — resolve it against the active album.
  /// A path that already contains slashes or is a URL is returned as-is
  /// (user-uploaded image or full Firebase Storage path).
  String? resolve(Word word) {
    final path = word.imagePath;
    if (path == null || path.isEmpty) return null;

    if (_isFullPath(path)) return path;

    return '$_coreBase/$selectedAlbum/$path';
  }

  static bool _isFullPath(String path) =>
      path.contains('/') ||
      path.startsWith('http') ||
      path.startsWith('file://');

  /// Returns the Firebase Storage path to use when uploading a new image for
  /// a user-created word.
  String userImageStoragePath(String userId, String filename) =>
      'users/$userId/images/$filename';
}
