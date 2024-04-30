import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/shared/image_with_loader.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

class FavoritesDetail extends StatelessWidget {
  const FavoritesDetail({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImagesProvider>();
    return Scaffold(
      body: Hero(
          tag: url,
          child: Stack(
            children: [
              Center(child: ImageWithLoader(image: url)),
              Positioned(
                bottom: 32,
                right: 16,
                child: TextButton.icon(
                  onPressed: () => provider.toggleLikedImage(url),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFA26334),
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(
                    provider.isLiked(url)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  label: const Text("Save"),
                ),
              )
            ],
          )),
    );
  }
}
