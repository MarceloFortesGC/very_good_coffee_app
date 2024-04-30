import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/details/details_image_model.dart';

class ImagesProvider with ChangeNotifier {
  final List<DetailsImageModel> _images = [];
  List<DetailsImageModel> get images => _images;
  void addImages(List<DetailsImageModel> imgList) {
    _images.addAll(imgList);
    notifyListeners();
  }
}
