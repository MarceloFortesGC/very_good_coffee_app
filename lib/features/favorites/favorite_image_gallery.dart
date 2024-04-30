import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/favorites/favorite_image_cached.dart';
import 'package:very_good_coffee_app/features/shared/animated_selection_indicator.dart';
import 'package:very_good_coffee_app/features/favorites/favorites_detail.dart';

class FavoriteImageGallery extends StatefulWidget {
  const FavoriteImageGallery({
    super.key,
    required this.url,
    required this.isSelected,
    required this.onSelect,
    required this.selectionActive,
  });
  final String url;
  final bool isSelected;
  final Function(String url) onSelect;
  final bool selectionActive;

  @override
  State<FavoriteImageGallery> createState() => _FavoriteImageGalleryState();
}

class _FavoriteImageGalleryState extends State<FavoriteImageGallery> {
  late String url;

  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  void _onPress() {
    if (widget.selectionActive) {
      widget.onSelect(url);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FavoritesDetail(url: widget.url)),
      );
    }
  }

  void _onLongPress() {
    widget.onSelect(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onPress,
        onLongPress: _onLongPress,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Hero(
              tag: widget.url,
              child: FavoriteImageCached(
                image: widget.url,
                padding: EdgeInsets.all(widget.isSelected ? 8 : 0),
              ),
            ),
            AnimatedSelectionIndicator(
              isSelected: widget.isSelected,
            ),
          ],
        ));
  }
}
