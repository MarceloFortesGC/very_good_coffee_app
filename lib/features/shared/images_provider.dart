import 'package:flutter/material.dart';

class ImagesProvider with ChangeNotifier {
  final List<String> _images = [];
  List<String> get images => _images;
  void addImages(List<String> imgList) {
    _images.addAll(imgList);
    notifyListeners();
  }

  final List<String> _likedImages = [];
  List<String> get likedImages => _likedImages;
  void toggleLikedImage(String img) {
    if (likedImages.contains(img)) {
      _likedImages.remove(img);
    } else {
      _likedImages.add(img);
    }
    notifyListeners();
  }

  bool isLiked(String image) {
    return _likedImages.contains(image);
  }
}
