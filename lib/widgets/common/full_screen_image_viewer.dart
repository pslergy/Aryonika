import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart'; // Нужно добавить в pubspec.yaml: photo_view: ^0.14.0

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  final String tag; // Для Hero анимации

  const FullScreenImageViewer({super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}