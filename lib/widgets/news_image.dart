import 'package:flutter/material.dart';

class NewsImage extends StatelessWidget {
  const NewsImage({
    super.key,
    required this.imageUrl,
    required this.semanticLabel,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  final String? imageUrl;
  final String semanticLabel;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fallback = Container(
      width: width,
      height: height,
      color: colors.secondaryContainer,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        size: 30,
        color: colors.onSecondaryContainer,
      ),
    );

    final url = imageUrl;
    return ClipRRect(
      borderRadius: borderRadius,
      child: url == null || url.isEmpty
          ? fallback
          : Image.network(
              url,
              width: width,
              height: height,
              fit: BoxFit.cover,
              semanticLabel: semanticLabel,
              errorBuilder: (context, error, stackTrace) => fallback,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: width,
                  height: height,
                  color: colors.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: const SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            ),
    );
  }
}
