import 'package:flutter/cupertino.dart';
import 'package:very_good_coffee_app/features/details/details_image_model.dart';
import 'package:very_good_coffee_app/features/details/details_page.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

class ImageWithLoader extends StatelessWidget {
  const ImageWithLoader({super.key, required this.image});
  final DetailsImageModel image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          const SkeletonCard(width: double.infinity, height: double.infinity),
          GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (_) {
                return DetailsPage(url: image.url);
              }));
            },
            child: Hero(
              tag: image.uuid,
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return const SkeletonCard(
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
