import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

import '../mocks/mock_shared_preferences.dart';

void main() {
  group('ImagesProvider Tests', () {
    late MockSharedPreferences mockPrefs;
    late ImagesProvider imagesProvider;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      SharedPreferences.setMockInitialValues({});
      imagesProvider = ImagesProvider();
    });

    test('addImages adds images and notifies listeners', () {
      var images = ['img1', 'img2'];

      imagesProvider.addListener(() {
        expect(imagesProvider.images, containsAll(images));
      });

      imagesProvider.addImages(images);
    });
  });
}
