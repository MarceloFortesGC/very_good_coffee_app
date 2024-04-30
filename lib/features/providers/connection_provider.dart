import 'package:flutter/material.dart';

class ConnectionProvider with ChangeNotifier {
  bool _hasConnection = true;
  bool get getHasConnection => _hasConnection;
  set setHasConnection(bool e) {
    _hasConnection = e;
    notifyListeners();
  }
}
