import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/favorites/favorite_image_gallery.dart';
import 'package:very_good_coffee_app/features/shared/animated_options.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<String> _selectedImages = [];

  _onSelectImage(String url) {
    if (_selectedImages.contains(url)) {
      _selectedImages.remove(url);
    } else {
      _selectedImages.add(url);
    }

    setState(() {});
  }

  _unlikeAllSelected() {
    final provider = Provider.of<ImagesProvider>(context, listen: false);

    for (var e in _selectedImages) {
      provider.toggleLikedImage(e);
    }

    _selectedImages.clear();
    setState(() {});
  }

  _cancelSelection() {
    _selectedImages.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImagesProvider>();
    return Stack(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your favorite photos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                Expanded(
                  child: provider.likedImages.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 56,
                                color: Colors.white,
                              ),
                              Divider(),
                              Text("You don't have any liked photos yet.")
                            ],
                          ),
                        )
                      : GridView.count(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2,
                          children: provider.likedImages.map((e) {
                            return FavoriteImageGallery(
                              url: e,
                              isSelected: _selectedImages.contains(e),
                              onSelect: (url) => _onSelectImage(url),
                              selectionActive: _selectedImages.isNotEmpty,
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
        AnimatedOptions(
          isVisible: _selectedImages.isNotEmpty,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: CustomColors.secondaryColor,
              ),
              onPressed: _unlikeAllSelected,
              icon: const Icon(Icons.heart_broken_rounded),
              label: const Text("Unlike Selected"),
            ),
            const Spacer(),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: CustomColors.secondaryColor,
              ),
              onPressed: _cancelSelection,
              icon: const Icon(Icons.close),
              label: const Text("Cancel"),
            ),
          ],
        )
      ],
    );
  }
}
