import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/shared/image_with_loader.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

class HomeOnline extends StatelessWidget {
  const HomeOnline({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final provider = context.watch<ImagesProvider>();

    Future<void> cacheImage(String imageUrl) async {
      final cacheManager = DefaultCacheManager();
      try {
        await cacheManager.downloadFile(imageUrl);
      } catch (e) {
        Future.delayed(Durations.short1).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "An error occurred while trying to like this photo, please check your connection and try again later.",
              ),
            ),
          );
        });
        throw 'Error: $e';
      }
    }

    Future<void> removeImageFromCache(String imageUrl) async {
      final cacheManager = DefaultCacheManager();
      try {
        // Remove a imagem do cache
        await cacheManager.removeFile(imageUrl);
      } catch (e) {
        Future.delayed(Durations.short1).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "An error occurred while trying to unlike this photo, please check your connection and try again later.",
              ),
            ),
          );
        });
        throw 'Error: $e';
      }
    }

    void onSave(String img) async {
      if (provider.isLiked(img)) {
        await removeImageFromCache(img).then((value) {
          provider.toggleLikedImage(img);
        });
      } else {
        await cacheImage(img).then((value) {
          provider.toggleLikedImage(img);
        });
      }
    }

    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: provider.images.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Center(child: ImageWithLoader(image: provider.images[index])),
              Positioned(
                bottom: 32,
                right: 16,
                child: TextButton.icon(
                  onPressed: () => onSave(provider.images[index]),
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColors.secondaryColor,
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(
                    provider.isLiked(provider.images[index])
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  label: Text(
                    provider.isLiked(provider.images[index])
                        ? "Unlike"
                        : "Like",
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
