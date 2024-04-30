import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/favorites/favorite_image_gallery.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> selectedImages = [];
  bool _selectionActive = false;

  _onSelectImage(String url) {
    if (selectedImages.contains(url)) {
      selectedImages.remove(url);
    } else {
      selectedImages.add(url);
    }

    _selectionActive = selectedImages.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImagesProvider>();
    return Container(
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
              child: GridView.count(
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                children: provider.likedImages.map((e) {
                  return FavoriteImageGallery(
                    url: e,
                    isSelected: selectedImages.contains(e),
                    onSelect: (url) => _onSelectImage(url),
                    selectionActive: _selectionActive,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
