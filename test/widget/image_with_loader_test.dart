import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:very_good_coffee_app/features/shared/image_with_loader.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

void main() {
  group('ImageWithLoader Tests', () {
    const String exampleImage =
        'https://coffee.alexflipnote.dev/Dhdy4wxPLo8_coffee.jpg';

    Widget getWidgetToTest({
      String? imageUrl,
      required Function() onDoubleTap,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ImageWithLoader(
            image: imageUrl ?? exampleImage,
            onDoubleTap: onDoubleTap,
          ),
        ),
      );
    }

    testWidgets('loads and displays image from network',
        (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(getWidgetToTest(onDoubleTap: () {}));
        await tester.pump();
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(SkeletonCard), findsOneWidget);
        for (int i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }
        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('tests onDoubleTap', (WidgetTester tester) async {
      int tapCount = 0;

      mockNetworkImagesFor(() async {
        // awaits image load from network as previous test
        await tester.pumpWidget(getWidgetToTest(onDoubleTap: () => tapCount++));
        await tester.pump(const Duration(seconds: 3));

        await tester.tap(find.byType(ImageWithLoader));
        await tester.pump(const Duration(milliseconds: 100));
        expect(tapCount, 0, reason: 'Just one should do nothing');

        await tester.tap(find.byType(ImageWithLoader));
        await tester.tap(find.byType(ImageWithLoader));
        await tester.pump(const Duration(milliseconds: 400));
        expect(tapCount, 1, reason: 'double tap should like image');
      });
    });
  });
}
