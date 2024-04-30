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
    // Inicia a animação de fade in imediatamente
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    // Inicia a animação de fade out após 500ms
    Timer(const Duration(milliseconds: 600), () {
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
