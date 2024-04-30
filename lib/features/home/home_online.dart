import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/shared/animated_like.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/shared/image_with_loader.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

class HomeOnline extends StatefulWidget {
  const HomeOnline({super.key});

  @override
  State<HomeOnline> createState() => _HomeOnlineState();
}

class _HomeOnlineState extends State<HomeOnline> {
  final controller = PageController();
  bool _savingImg = false;

  void _showHeartAnimation(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 50,
        child: const AnimatedLike(),
      );
    });

    Overlay.of(context).insert(overlayEntry);

    Timer(const Duration(seconds: 1), () => overlayEntry.remove());
  }

  Future<void> _cacheImage(String imageUrl) async {
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

  Future<void> _removeImageFromCache(String imageUrl) async {
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

  void _onSave(String img) async {
    _showHeartAnimation(context);
    final provider = Provider.of<ImagesProvider>(context, listen: false);
    provider.toggleLikedImage(img);
    _savingImg = true;
    setState(() {});

    try {
      if (provider.isLiked(img)) {
        await _removeImageFromCache(img);
      } else {
        await _cacheImage(img);
      }
    } catch (e) {
      provider.toggleLikedImage(img);
    }

    _savingImg = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImagesProvider>();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                  'Very Good Coffee App',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: provider.images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Center(
                            child: ImageWithLoader(
                              image: provider.images[index],
                              onDoubleTap: () =>
                                  _onSave(provider.images[index]),
                            ),
                          ),
                          Positioned(
                            bottom: 32,
                            right: 16,
                            child: TextButton.icon(
                              onPressed: _savingImg
                                  ? null
                                  : () => _onSave(provider.images[index]),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
