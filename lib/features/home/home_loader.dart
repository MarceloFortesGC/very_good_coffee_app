import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

class HomeLoader extends StatelessWidget {
  const HomeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: SkeletonCard(
          width: double.infinity,
          height: size.height * .5,
        ),
      )),
    );
  }
}
