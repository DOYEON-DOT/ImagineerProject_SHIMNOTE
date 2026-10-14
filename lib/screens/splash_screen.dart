import 'dart:async';

import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';

/// 1. 스플래시
/// 2초 뒤(또는 화면을 탭하면) 온보딩으로 이동합니다.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _moved = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _next);
  }

  void _next() {
    if (_moved || !mounted) return;
    _moved = true;
    Nav.resetTo(context, AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Tap(
        onTap: _next,
        child: Stack(
          children: [
            const Positioned(top: -60, left: -40, child: BubbleDeco(size: 220)),
            const Positioned(bottom: -80, right: -60, child: BubbleDeco(size: 260)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.png', width: 220, semanticLabel: 'ShimNote 로고'),
                  const SizedBox(height: 14),
                  Text('오늘의 감정을 담아보세요', style: ts(14, color: AppColors.textSub2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
