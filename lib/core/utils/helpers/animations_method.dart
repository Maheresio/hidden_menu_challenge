import 'package:flutter/material.dart';

import '../app_constants.dart';

Map<String, Animation> createAnimations(
    int index, AnimationController controller) {
  final animationDelay = index / AppConstants.itemsList.length;

  final slideAnimation = Tween<Offset>(
    begin: Offset(0, 1), // Start offscreen (below)
    end: Offset(0, 0), // Move to original position
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        animationDelay,
        (animationDelay + 1 / AppConstants.itemsList.length).clamp(0.0, 1.0),
        curve: Curves.easeInOut,
      ),
    ),
  );

  final fadeAnimation = Tween<double>(
    begin: 0, // Start fully transparent
    end: 1, // End fully opaque
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        animationDelay,
        (animationDelay + 1 / AppConstants.itemsList.length).clamp(0.0, 1.0),
        curve: Curves.easeInOut,
      ),
    ),
  );

  final scaleAnimation = Tween<double>(
    begin: 0.5, // Start scaled down
    end: 1, // End at normal scale
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(
        animationDelay,
        (animationDelay + 1 / AppConstants.itemsList.length).clamp(0.0, 1.0),
        curve: Curves.easeInOut,
      ),
    ),
  );

  return {
    'slide': slideAnimation,
    'fade': fadeAnimation,
    'scale': scaleAnimation,
  };
}
