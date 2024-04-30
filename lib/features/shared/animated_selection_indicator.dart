import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';

class AnimatedSelectionIndicator extends StatefulWidget {
  const AnimatedSelectionIndicator({super.key, required this.isSelected});
  final bool isSelected;

  @override
  AnimatedSelectionIndicatorState createState() =>
      AnimatedSelectionIndicatorState();
}

class AnimatedSelectionIndicatorState extends State<AnimatedSelectionIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _updateAnimation();
  }

  @override
  void didUpdateWidget(covariant AnimatedSelectionIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.isSelected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedOpacity(
        opacity: widget.isSelected ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.secondaryColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
