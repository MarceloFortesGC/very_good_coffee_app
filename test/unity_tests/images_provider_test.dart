import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

void main() {
  List<String> imgs = ['img1', 'img2', 'img3'];
  List<String> likedImgs = ['img1', 'img3'];

  group('ImagesProvider Tests', () {
    late ImagesProvider imagesProvider;

    Future<void> setupSharedPreferences(List<String> likedImages) async {
      SharedPreferences.setMockInitialValues({'liked': likedImages});
    }

    setUp(() {
      setupSharedPreferences([]);
      imagesProvider = ImagesProvider();
    });

    test('add images to home', () {
      imagesProvider.addImages(imgs);
      expect(imagesProvider.images, containsAll(imgs));
    });

    test('add image to liked images', () {
      for (String e in imgs) {
        imagesProvider.toggleLikedImage(e);
      }
      expect(imagesProvider.likedImages, containsAll(imgs));
    });

    test('like and unlike image', () async {
      // like image
      imagesProvider.toggleLikedImage(imgs.first);
      await Future.delayed(Durations.short1).then((value) {
        // unlike image
        imagesProvider.toggleLikedImage(imgs.first);
      });
      expect(imagesProvider.likedImages, isEmpty);
    });

    test('unlike specific image', () {
      for (String e in imgs) {
        imagesProvider.toggleLikedImage(e);
      }

      imagesProvider.toggleLikedImage('img2');
      expect(imagesProvider.likedImages, isNot(contains('img2')));
    });

    test('check if image is liked', () {
      imagesProvider.toggleLikedImage('img2');
      expect(imagesProvider.isLiked('img2'), isTrue);
    });

    test('check if image is unliked', () {
      expect(imagesProvider.isLiked('img2'), isFalse);
    });

    test('start project with no images on SharedPreferences', () {
      setupSharedPreferences([]);
      expect(imagesProvider.likedImages, isEmpty);
    });

    test(
        'getLikedImagesOffline should load liked images from SharedPreferences',
        () async {
      setupSharedPreferences(likedImgs);

      imagesProvider = ImagesProvider();

      await imagesProvider.getLikedImagesOffline();

      expect(imagesProvider.likedImages, containsAll(likedImgs));
    });
  });
}
