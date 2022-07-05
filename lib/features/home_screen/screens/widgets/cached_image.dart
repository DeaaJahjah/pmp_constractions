import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';

class CashedImage extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final double? radius;
  const CashedImage({Key? key, required this.imageUrl, this.size, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        width: size,
        height: size,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
                value: downloadProgress.progress, color: orange),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
