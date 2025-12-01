import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/k_images.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  });

  final String? path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    final imagePath = path ?? KImages.kNetworkImage; // Default fallback image

    if (isFile) {
      return Image.file(
        File(imagePath),
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }

    if (imagePath.endsWith('.svg')) {
      if (imagePath.startsWith('http') ||
          imagePath.startsWith('https') ||
          imagePath.startsWith('www.')) {
        return SvgPicture.network(
          imagePath,
          fit: fit,
          height: height,
          width: width,
          color: color,
          placeholderBuilder: (BuildContext context) =>
          const Center(child: CircularProgressIndicator()),
          // Placeholder while loading
          // Handle network errors gracefully
          semanticsLabel: 'Network SVG',
        );
      } else {
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath,
            fit: fit,
            height: height,
            width: width,
            color: color,
            semanticsLabel: 'Local SVG',
          ),
        );
      }
    }

    if (imagePath.startsWith('http') ||
        imagePath.startsWith('https') ||
        imagePath.startsWith('www.')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: fit,
        color: color,
        height: height,
        width: width,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const CustomImage(path: KImages.placeholderImage),
      );
    }

    return Image.asset(
      imagePath,
      fit: fit,
      color: color,
      height: height,
      width: width,
    );
  }
}
