import 'package:flutter/material.dart';

class AnimatedOptions extends StatefulWidget {
  const AnimatedOptions({
    super.key,
    required this.isVisible,
    required this.children,
  });
  final bool isVisible;
  final List<Widget> children;

  @override
  AnimatedOptionsState createState() => AnimatedOptionsState();
}

class AnimatedOptionsState extends State<AnimatedOptions>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Inicializa a animação baseada no estado inicial de isVisible
    if (widget.isVisible) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedOptions oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Atualiza a animação quando o valor de isVisible muda
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: Offset(0.0, (1 - _animation.value) * 100),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.children,
              ),
            ),
          ),
        );
      },
    );
  }
}
