import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/providers/connection_provider.dart';

void main() {
  group('Connection Provider Tests', () {
    late ConnectionProvider connectionProvider;

    setUp(() {
      connectionProvider = ConnectionProvider();
    });

    test('start provider with connection true', () async {
      expect(connectionProvider.getHasConnection, isTrue);
    });

    test('set provider connection to false and get', () async {
      connectionProvider.setHasConnection = false;
      expect(connectionProvider.getHasConnection, isFalse);
    });
  });
}
