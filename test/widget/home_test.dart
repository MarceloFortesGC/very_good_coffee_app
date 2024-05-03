import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/main.dart';

import '../mocks/mock_connection_provider.dart';

void main() {
  late MockConnectionProvider mockConnectionProvider;

  Future<void> setupConnectionState(bool connected) async {
    mockConnectionProvider.setHasConnection = connected;
  }

  setUp(() {
    mockConnectionProvider = MockConnectionProvider();
    setupConnectionState(true);
  });

  testWidgets('test render of Home Page', (tester) async {
    await tester.pumpWidget(const VeryGoodCoffeeApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('onlineOrOfflineWrapper')), findsOneWidget);
  });
}
