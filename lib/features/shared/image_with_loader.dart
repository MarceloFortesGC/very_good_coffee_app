import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/shared/error_msg.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

class ImageWithLoader extends StatefulWidget {
  const ImageWithLoader({
    super.key,
    required this.image,
    this.padding,
    required this.onDoubleTap,
  });
  final String image;
  final EdgeInsetsGeometry? padding;
  final Function() onDoubleTap;

  @override
  State<ImageWithLoader> createState() => _ImageWithLoaderState();
}

class _ImageWithLoaderState extends State<ImageWithLoader> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onDoubleTap: widget.onDoubleTap,
      child: AnimatedContainer(
        duration: Durations.short1,
        padding: widget.padding ?? EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              SkeletonCard(width: double.infinity, height: size.height * .5),
              Image.network(
                widget.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: size.height * .5,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: size.height * .5,
                    color: CustomColors.secondaryColor,
                    child: const ErrorMsg(),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
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
      ),
    );
  }
}
