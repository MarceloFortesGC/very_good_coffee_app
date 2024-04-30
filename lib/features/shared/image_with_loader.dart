import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

class ImageWithLoader extends StatelessWidget {
  const ImageWithLoader({super.key, required this.image, this.padding});
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
            SkeletonCard(
              width: double.infinity,
              height: size.height * .5,
            ),
            Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * .5,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return child;
                return SkeletonCard(
                  width: double.infinity,
                  height: size.height * .5,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
