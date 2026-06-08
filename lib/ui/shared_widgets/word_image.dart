import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Displays a word image from any of four sources:
///   - HTTP/HTTPS URL        → CachedNetworkImage (disk-cached)
///   - Local file path       → Image.file
///   - Firebase Storage path → resolves to download URL then CachedNetworkImage
///   - Local asset path      → Image.asset
///   - null / empty          → fallback placeholder
class WordImage extends StatefulWidget {
  static final _urlCache = <String, String>{};

  const WordImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String? imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;

  static const _fallbackAsset =
      'assets/images/simple_aac_white_background.png';

  @override
  State<WordImage> createState() => _WordImageState();
}

class _WordImageState extends State<WordImage> {
  Future<String>? _storageFuture;
  String? _activePath;

  @override
  void initState() {
    super.initState();
    _syncFuture();
  }

  @override
  void didUpdateWidget(WordImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _syncFuture();
    }
  }

  void _syncFuture() {
    final path = widget.imagePath;
    if (path == null ||
        path.isEmpty ||
        path.startsWith('http') ||
        path.startsWith('/') ||
        path.startsWith('file://') ||
        path.startsWith('assets/')) {
      _storageFuture = null;
      _activePath = null;
      return;
    }
    // Firebase Storage path — only create a new future if the path changed.
    if (path != _activePath) {
      _activePath = path;
      _storageFuture =
          FirebaseStorage.instance.ref(path).getDownloadURL().then((url) {
        WordImage._urlCache[path] = url;
        return url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.imagePath;

    if (path == null || path.isEmpty) {
      return _asset(WordImage._fallbackAsset);
    }

    if (path.startsWith('http')) {
      return _cached(path);
    }

    if (path.startsWith('/') || path.startsWith('file://')) {
      return _file(path.replaceFirst('file://', ''));
    }

    if (!path.startsWith('assets/')) {
      return FutureBuilder<String>(
        future: _storageFuture,
        initialData: WordImage._urlCache[path],
        builder: (context, snapshot) {
          if (snapshot.hasData) return _cached(snapshot.data!);
          if (snapshot.hasError) return _asset(WordImage._fallbackAsset);
          return _shimmer();
        },
      );
    }

    return _asset(path);
  }

  Widget _file(String path) => Image.file(
        File(path),
        fit: widget.fit,
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        errorBuilder: (_, __, ___) => _asset(WordImage._fallbackAsset),
      );

  Widget _cached(String url) => CachedNetworkImage(
        imageUrl: url,
        fit: widget.fit,
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        placeholder: (_, __) => _shimmer(),
        errorWidget: (_, __, ___) => _asset(WordImage._fallbackAsset),
      );

  Widget _asset(String assetPath) => Image.asset(
        assetPath,
        fit: widget.fit,
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(),
      );

  Widget _shimmer() {
    final colorScheme = Theme.of(context).colorScheme;
    final baseColor = colorScheme.surfaceContainerHighest;
    final highlightColor = colorScheme.surfaceContainerLow;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        child: ColoredBox(color: baseColor),
      ),
    );
  }

  Widget _placeholder() => SizedBox(
        width: widget.width,
        height: widget.height,
        child: const ColoredBox(
          color: Colors.black12,
          child: Icon(Icons.image_not_supported, color: Colors.black38),
        ),
      );
}
