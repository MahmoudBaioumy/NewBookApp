import 'dart:math';

import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flutter/material.dart';

class AnimatedBookSplashWidget extends StatefulWidget {
  const AnimatedBookSplashWidget({super.key});

  @override
  State<AnimatedBookSplashWidget> createState() => _AnimatedBookSplashWidgetState();
}

class _AnimatedBookSplashWidgetState extends State<AnimatedBookSplashWidget> with SingleTickerProviderStateMixin {
  // ========================== 🔒 Private constants 🔒 ========================== //
  static const int _animationCycleMilliseconds = 2400;
  static const double _widgetSize = 240.0;
  static const double _outerGlowSize = 210.0;
  static const double _innerGlowSize = 155.0;
  static const double _bookCanvasWidth = 170.0;
  static const double _bookCanvasHeight = 140.0;
  static const double _maxFloatOffset = 8.0;
  static const double _minPulseScale = 0.92;
  static const double _maxPulseScale = 1.06;
  static const double _fullCircleRadians = 2 * pi;

  // ========================== 🔒 Private variables 🔒 ========================== //
  late final AnimationController _animationController;

  // ========================== 🔥 Initialization 🔥 ========================== //
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _animationCycleMilliseconds),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ========================== 🖥️ Build 🖥️ ========================== //
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) => _buildAnimatedScene(),
    );
  }

  // --------------------------[ _buildAnimatedScene ]-------------------------- //
  Widget _buildAnimatedScene() {
    final progress = _animationController.value;
    final waveValue = sin(progress * _fullCircleRadians);
    final floatOffset = waveValue * _maxFloatOffset;
    final glowScale = _minPulseScale + ((waveValue + 1) * 0.5) * (_maxPulseScale - _minPulseScale);

    return SizedBox(
      width: _widgetSize,
      height: _widgetSize,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _buildOuterGlowRing(glowScale),
          _buildInnerGlowCircle(glowScale),
          _buildFloatingBook(progress, floatOffset),
        ],
      ),
    );
  }

  // --------------------------[ _buildOuterGlowRing ]-------------------------- //
  Widget _buildOuterGlowRing(double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: _outerGlowSize,
        height: _outerGlowSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryTint,
        ),
      ),
    );
  }

  // --------------------------[ _buildInnerGlowCircle ]-------------------------- //
  Widget _buildInnerGlowCircle(double scale) {
    final inverseScale = (_minPulseScale + _maxPulseScale) - scale;
    return Transform.scale(
      scale: inverseScale,
      child: Container(
        width: _innerGlowSize,
        height: _innerGlowSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryTint2,
        ),
      ),
    );
  }

  // --------------------------[ _buildFloatingBook ]-------------------------- //
  Widget _buildFloatingBook(double progress, double floatOffset) {
    return Transform.translate(
      offset: Offset(0, floatOffset),
      child: CustomPaint(
        size: const Size(_bookCanvasWidth, _bookCanvasHeight),
        painter: _LottieStyleBookPainter(
          progress: progress,
          coverColor: AppColors.primaryHover,
          spineColor: AppColors.primary,
          pageSurfaceColor: AppColors.surfaceContainer,
          pageBorderColor: AppColors.outlineVariant,
          pageLinesColor: AppColors.outline,
          bookmarkColor: AppColors.accent,
          sparkleColor: AppColors.primary,
          shadowColor: AppColors.coldTint,
        ),
      ),
    );
  }
}

class _LottieStyleBookPainter extends CustomPainter {
  // ========================== Constructor ========================== //
  const _LottieStyleBookPainter({
    required this.progress,
    required this.coverColor,
    required this.spineColor,
    required this.pageSurfaceColor,
    required this.pageBorderColor,
    required this.pageLinesColor,
    required this.bookmarkColor,
    required this.sparkleColor,
    required this.shadowColor,
  });

  // ========================== 🔒 Properties 🔒 ========================== //
  final double progress;
  final Color coverColor;
  final Color spineColor;
  final Color pageSurfaceColor;
  final Color pageBorderColor;
  final Color pageLinesColor;
  final Color bookmarkColor;
  final Color sparkleColor;
  final Color shadowColor;

  static const int _flippingPagesCount = 3;
  static const double _bookHalfWidth = 62.0;
  static const double _bookHeight = 76.0;
  static const double _coverPadding = 6.0;
  static const double _coverCornerRadius = 8.0;
  static const double _spineHalfWidth = 7.0;
  static const double _pageArchHeight = 10.0;
  static const double _fullCircleRadians = 2 * pi;

  // --------------------------[ paint ]-------------------------- //
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.56);

    _drawDropShadow(canvas, center);
    _drawBookCover(canvas, center);
    _drawStaticPagesStack(canvas, center);
    _drawBookmarkRibbon(canvas, center);
    _drawFlippingPages(canvas, center);
    _drawCenterSpine(canvas, center);
    _drawFloatingSparkles(canvas, center);
  }

  // --------------------------[ _drawDropShadow ]-------------------------- //
  void _drawDropShadow(Canvas canvas, Offset center) {
    final breathFactor = 1.0 - (sin(progress * _fullCircleRadians) * 0.12);
    final shadowRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + (_bookHeight * 0.5) + 18),
      width: (_bookHalfWidth * 2.0) * breathFactor,
      height: 14.0 * breathFactor,
    );
    final shadowPaint = Paint()
      ..color = shadowColor
      ..style = PaintingStyle.fill;
    canvas.drawOval(shadowRect, shadowPaint);
  }

  // --------------------------[ _drawBookCover ]-------------------------- //
  void _drawBookCover(Canvas canvas, Offset center) {
    final coverRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + 3),
      width: (_bookHalfWidth + _coverPadding) * 2,
      height: _bookHeight + (_coverPadding * 2),
    );
    final roundedCover = RRect.fromRectAndRadius(
      coverRect,
      const Radius.circular(_coverCornerRadius),
    );
    final coverPaint = Paint()
      ..color = coverColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(roundedCover, coverPaint);
  }

  // --------------------------[ _drawStaticPagesStack ]-------------------------- //
  void _drawStaticPagesStack(Canvas canvas, Offset center) {
    _drawSingleSidePageBlock(canvas, center, isRightSide: false);
    _drawSingleSidePageBlock(canvas, center, isRightSide: true);
  }

  // --------------------------[ _drawSingleSidePageBlock ]-------------------------- //
  void _drawSingleSidePageBlock(Canvas canvas, Offset center, {required bool isRightSide}) {
    final direction = isRightSide ? 1.0 : -1.0;
    final topY = center.dy - (_bookHeight * 0.5);
    final bottomY = center.dy + (_bookHeight * 0.5);
    final outerX = center.dx + (direction * _bookHalfWidth);
    final controlX = center.dx + (direction * (_bookHalfWidth * 0.5));

    final pagePath = Path()
      ..moveTo(center.dx, topY)
      ..quadraticBezierTo(controlX, topY - _pageArchHeight, outerX, topY)
      ..lineTo(outerX, bottomY)
      ..quadraticBezierTo(controlX, bottomY - _pageArchHeight, center.dx, bottomY)
      ..close();

    final fillPaint = Paint()
      ..color = pageSurfaceColor
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = pageBorderColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(pagePath, fillPaint);
    canvas.drawPath(pagePath, borderPaint);

    _drawPageContentLines(canvas, center, direction, topY);
  }

  // --------------------------[ _drawPageContentLines ]-------------------------- //
  void _drawPageContentLines(Canvas canvas, Offset center, double direction, double topY) {
    final linePaint = Paint()
      ..color = pageLinesColor
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    const lineCount = 4;
    const startMargin = 14.0;
    const endMargin = 12.0;

    for (var i = 0; i < lineCount; i++) {
      final lineY = topY + 16.0 + (i * 14.0);
      final widthFactor = i == lineCount - 1 ? 0.65 : 1.0;
      final startX = center.dx + (direction * startMargin);
      final endX = center.dx + (direction * (startMargin + ((_bookHalfWidth - startMargin - endMargin) * widthFactor)));
      canvas.drawLine(Offset(startX, lineY - 3), Offset(endX, lineY - 3), linePaint);
    }
  }

  // --------------------------[ _drawBookmarkRibbon ]-------------------------- //
  void _drawBookmarkRibbon(Canvas canvas, Offset center) {
    final bottomY = center.dy + (_bookHeight * 0.5);
    final swayOffset = sin(progress * _fullCircleRadians) * 3.0;
    final ribbonPath = Path()
      ..moveTo(center.dx - 4, bottomY - 2)
      ..lineTo(center.dx + 4, bottomY - 2)
      ..lineTo(center.dx + 6 + swayOffset, bottomY + 20)
      ..lineTo(center.dx + swayOffset, bottomY + 15)
      ..lineTo(center.dx - 6 + swayOffset, bottomY + 20)
      ..close();

    final ribbonPaint = Paint()
      ..color = bookmarkColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(ribbonPath, ribbonPaint);
  }

  // --------------------------[ _drawFlippingPages ]-------------------------- //
  void _drawFlippingPages(Canvas canvas, Offset center) {
    for (var i = 0; i < _flippingPagesCount; i++) {
      final staggeredProgress = (progress + (i / _flippingPagesCount)) % 1.0;
      _drawSingleFlippingPage(canvas, center, staggeredProgress);
    }
  }

  // --------------------------[ _drawSingleFlippingPage ]-------------------------- //
  void _drawSingleFlippingPage(Canvas canvas, Offset center, double pageCycle) {
    final easedTurn = Curves.easeInOutCubic.transform(pageCycle);
    final angle = easedTurn * pi;
    final horizontalReach = cos(angle) * _bookHalfWidth;
    final verticalLift = sin(angle) * 18.0;

    final topY = center.dy - (_bookHeight * 0.5);
    final bottomY = center.dy + (_bookHeight * 0.5);
    final outerX = center.dx + horizontalReach;
    final outerTopY = topY - verticalLift;
    final outerBottomY = bottomY - verticalLift;

    final controlX = center.dx + (horizontalReach * 0.55);
    final controlLift = verticalLift + (_pageArchHeight * sin(angle));

    final flippingPath = Path()
      ..moveTo(center.dx, topY)
      ..quadraticBezierTo(controlX, topY - controlLift, outerX, outerTopY)
      ..lineTo(outerX, outerBottomY)
      ..quadraticBezierTo(controlX, bottomY - controlLift, center.dx, bottomY)
      ..close();

    final fillPaint = Paint()
      ..color = pageSurfaceColor
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = spineColor
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    canvas.drawPath(flippingPath, fillPaint);
    canvas.drawPath(flippingPath, borderPaint);
  }

  // --------------------------[ _drawCenterSpine ]-------------------------- //
  void _drawCenterSpine(Canvas canvas, Offset center) {
    final spineRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: _spineHalfWidth * 2,
        height: _bookHeight + 8,
      ),
      const Radius.circular(4),
    );
    final spinePaint = Paint()
      ..color = spineColor
      ..style = PaintingStyle.fill;
    canvas.drawRRect(spineRect, spinePaint);
  }

  // --------------------------[ _drawFloatingSparkles ]-------------------------- //
  void _drawFloatingSparkles(Canvas canvas, Offset center) {
    _drawSingleSparkle(
      canvas: canvas,
      basePosition: Offset(center.dx - 52, center.dy - 58),
      phaseOffset: 0.0,
      maxRadius: 5.5,
      color: bookmarkColor,
    );
    _drawSingleSparkle(
      canvas: canvas,
      basePosition: Offset(center.dx + 56, center.dy - 52),
      phaseOffset: 0.35,
      maxRadius: 6.5,
      color: sparkleColor,
    );
    _drawSingleSparkle(
      canvas: canvas,
      basePosition: Offset(center.dx, center.dy - 74),
      phaseOffset: 0.7,
      maxRadius: 5.0,
      color: bookmarkColor,
    );
  }

  // --------------------------[ _drawSingleSparkle ]-------------------------- //
  void _drawSingleSparkle({
    required Canvas canvas,
    required Offset basePosition,
    required double phaseOffset,
    required double maxRadius,
    required Color color,
  }) {
    final localPhase = (progress + phaseOffset) % 1.0;
    final pulse = sin(localPhase * pi);
    final radius = maxRadius * pulse;
    if (radius <= 0.5) return;

    final sparkleCenter = Offset(basePosition.dx, basePosition.dy - (localPhase * 10.0));
    final diamondPath = Path()
      ..moveTo(sparkleCenter.dx, sparkleCenter.dy - radius)
      ..quadraticBezierTo(sparkleCenter.dx, sparkleCenter.dy, sparkleCenter.dx + radius, sparkleCenter.dy)
      ..quadraticBezierTo(sparkleCenter.dx, sparkleCenter.dy, sparkleCenter.dx, sparkleCenter.dy + radius)
      ..quadraticBezierTo(sparkleCenter.dx, sparkleCenter.dy, sparkleCenter.dx - radius, sparkleCenter.dy)
      ..quadraticBezierTo(sparkleCenter.dx, sparkleCenter.dy, sparkleCenter.dx, sparkleCenter.dy - radius)
      ..close();

    final sparklePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(diamondPath, sparklePaint);
  }

  // --------------------------[ shouldRepaint ]-------------------------- //
  @override
  bool shouldRepaint(covariant _LottieStyleBookPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.coverColor != coverColor ||
      oldDelegate.pageSurfaceColor != pageSurfaceColor;
}
