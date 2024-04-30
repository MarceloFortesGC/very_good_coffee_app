import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedLike extends StatefulWidget {
  const AnimatedLike({super.key});

  @override
  AnimatedLikeState createState() => AnimatedLikeState();
}

class AnimatedLikeState extends State<AnimatedLike> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 50), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    Timer(const Duration(milliseconds: 550), () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      child: const Icon(Icons.favorite, color: Colors.red, size: 100),
    );
  }
}
