import 'dart:async';

import 'package:flutter/material.dart';

class StaggeredListAnimationWidget extends StatefulWidget {
  // ========================== Constructor ========================== //
  const StaggeredListAnimationWidget({
    super.key,
    required this.index,
    required this.child,
  });

  // ========================== 🔒 Final Variables 🔒 ========================== //
  static const int _baseDelayMs = 70;
  static const int _maxDelayMs = 420;
  static const int _animationDurationMs = 450;
  static const double _initialVerticalOffset = 0.22;

  final int index;
  final Widget child;

  @override
  State<StaggeredListAnimationWidget> createState() =>
      _StaggeredListAnimationWidgetState();
}

class _StaggeredListAnimationWidgetState
    extends State<StaggeredListAnimationWidget>
    with SingleTickerProviderStateMixin {
  // ========================== 🔒 Private variables 🔒 ========================== //
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: StaggeredListAnimationWidget._animationDurationMs,
      ),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      curvedAnimation,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(
        0.0,
        StaggeredListAnimationWidget._initialVerticalOffset,
      ),
      end: Offset.zero,
    ).animate(curvedAnimation);

    final delayMilliseconds =
        (widget.index * StaggeredListAnimationWidget._baseDelayMs).clamp(
          0,
          StaggeredListAnimationWidget._maxDelayMs,
        );

    _delayTimer = Timer(Duration(milliseconds: delayMilliseconds), () {
      if (mounted) _animationController.forward();
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  // ========================== 🌍 Build 🌍 ========================== //
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
