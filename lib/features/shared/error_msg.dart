import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  const ErrorMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.coffee_outlined, size: 56, color: Colors.white),
        Divider(),
        Text(
          'Looks like you are offline.',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(1.2),
        ),
        Divider(),
        Text(
          'Please verify your internet connection to get more coffee photos!',
          textAlign: TextAlign.center,
        ),
        Divider(),
        Text(
          'You can still see your Favorite Photos!',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
