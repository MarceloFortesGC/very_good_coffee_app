import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/skeleton.dart';

class HomeLoaderSkeleton extends StatelessWidget {
  const HomeLoaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double skeletonHeight = size.height * 0.2;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: SkeletonCard(
                height: skeletonHeight,
                width: double.maxFinite,
              ),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 2,
              child: SkeletonCard(
                height: skeletonHeight,
                width: double.maxFinite,
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SkeletonCard(
                height: skeletonHeight,
                width: double.maxFinite,
              ),
            ),
            const VerticalDivider(),
            Expanded(
              flex: 1,
              child: SkeletonCard(
                height: skeletonHeight,
                width: double.maxFinite,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
