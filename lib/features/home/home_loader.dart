import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/home/home_loader_skeleton.dart';

class HomeLoader extends StatelessWidget {
  const HomeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          HomeLoaderSkeleton(),
          Divider(),
          HomeLoaderSkeleton(),
        ],
      ),
    );
  }
}
