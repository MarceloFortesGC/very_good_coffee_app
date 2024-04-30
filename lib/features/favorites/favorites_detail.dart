import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/shared/image_with_loader.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

class FavoritesDetail extends StatelessWidget {
  const FavoritesDetail({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImagesProvider>();
    void onLike() {
      provider.toggleLikedImage(url);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Hero(
            tag: url,
            child: Stack(
              children: [
                Center(
                  child: ImageWithLoader(
                    image: url,
                    onDoubleTap: onLike,
                  ),
                ),
                Positioned(
                  bottom: 32,
                  right: 16,
                  child: TextButton.icon(
                    onPressed: onLike,
                    style: TextButton.styleFrom(
                      backgroundColor: CustomColors.secondaryColor,
                      foregroundColor: Colors.white,
                    ),
                    icon: Icon(
                      provider.isLiked(url)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    label: Text(
                      provider.isLiked(url) ? "Unlike" : "Like",
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
