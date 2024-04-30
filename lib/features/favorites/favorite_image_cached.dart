import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

class FavoriteImageCached extends StatelessWidget {
  const FavoriteImageCached({super.key, required this.image, this.padding});
  final String image;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Durations.short1,
      padding: padding ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            SkeletonCard(width: double.infinity, height: size.height * .5),
            CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * .5,
            ),
          ],
        ),
      ),
    );
  }
}
