import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/home/home_service.dart';

void main() {
  group('HomeService Tests', () {
    test('getListImageHomePage returns a list of image URLs', () async {
      final result = await HomeService().getListImageHomePage();
      expect(result.length, 10);
      expect(result.first, isA<String>());
    });
  });
}
