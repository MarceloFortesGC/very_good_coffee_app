import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagesProvider with ChangeNotifier {
  final _prefs = SharedPreferences.getInstance();

  final List<String> _images = [];
  List<String> get images => _images;
  void addImages(List<String> imgList) {
    _images.addAll(imgList);
    notifyListeners();
  }

  final List<String> _likedImages = [];
  List<String> get likedImages => _likedImages;
  void toggleLikedImage(String img) async {
    if (likedImages.contains(img)) {
      _likedImages.remove(img);
    } else {
      _likedImages.add(img);
    }

    (await _prefs).setStringList('liked', _likedImages);
    notifyListeners();
  }

  bool isLiked(String image) {
    return _likedImages.contains(image);
  }

  Future<void> getLikedImagesOffline() async {
    _likedImages.addAll((await _prefs).getStringList('liked') ?? []);
    notifyListeners();
  }
}
