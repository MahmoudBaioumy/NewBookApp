import 'dart:async';

import 'package:flustra_template/core/router/navigation_manager.dart';
import 'package:flustra_template/modules/splash/widgets/animated_book_splash_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // ========================== 🔒 Private variables 🔒 ========================== //
  static const Duration _splashDuration = Duration(seconds: 3);

  Timer? _timer;
  bool _hasNavigated = false;

  // ========================== 🔥 Initialization 🔥 ========================== //
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // --------------------------[ _startTimer ]-------------------------- //
  void _startTimer() {
    _timer = Timer(_splashDuration, _navigateToNextScreen);
  }

  // --------------------------[ _onTapScreen ]-------------------------- //
  void _onTapScreen() {
    if (_hasNavigated) return;
    _timer?.cancel();
    _navigateToNextScreen();
  }

  // --------------------------[ _navigateToNextScreen ]-------------------------- //
  void _navigateToNextScreen() {
    if (_hasNavigated) return;
    _hasNavigated = true;
    _timer?.cancel();

    NavigationManager.navigateFromSplash();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ========================== 🖥️ Build 🖥️ ========================== //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTapScreen,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --------------------------[ Animated Book ]-------------------------- //
            _buildAnimatedBookSection(),
          ],
        ),
      ),
    );
  }

  // --------------------------[ Animated Book Section ]-------------------------- //
  Widget _buildAnimatedBookSection() => const AnimatedBookSplashWidget();
}
