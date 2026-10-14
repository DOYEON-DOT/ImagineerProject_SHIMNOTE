import 'dart:async';

import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/animations.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

/// 5. 분석
/// 3초 뒤 자동으로(또는 화면을 탭하면) 6. 웰니스 스코어로 이동합니다.
/// (분석 화면은 스택에 남기지 않도록 replace 합니다)
class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen> {
  Timer? _timer;
  bool _moved = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), _next);
  }

  void _next() {
    if (_moved || !mounted) return;
    _moved = true;
    Nav.replace(context, AppRoutes.wellness);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tap(
        onTap: _next,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.6, -1),
              end: Alignment(0.6, 1),
              colors: [Color(0xFFE9F8F2), Color(0xFFCDEEE5)],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: topPad(context, 24), bottom: bottomPad(context, 64)),
                child: ShrinkToFit(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            const RippleRings(
                              ringSize: 210,
                              color: AppColors.primary,
                              duration: Duration(seconds: 3),
                              scaleFrom: 0.7,
                              scaleTo: 2.1,
                              opacityFrom: 0.55,
                            ),
                            Container(
                              width: 140,
                              height: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: AppColors.cardShadow(0.18, 24, 8),
                              ),
                              child: Bounce(child: Svg(AppIcons.drop(AppColors.primary), size: 64)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 44),
                      Svg(AppIcons.pulseLine(), size: 180, height: 26),
                      const SizedBox(height: 44),
                      Text('감정을 살펴보고 있어요', style: ts(17, weight: bold)),
                      const SizedBox(height: 10),
                      Text(
                        '약간의 시간이 소요될 수 있어요.\n잠시만 기다려주세요',
                        textAlign: TextAlign.center,
                        style: ts(13, color: AppColors.textSub2, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: bottomPad(context, 40),
                child: Opacity(
                  opacity: 0.7,
                  child: Text(
                    '분석이 끝나면 자동으로 다음 화면으로 이동해요',
                    textAlign: TextAlign.center,
                    style: ts(11, color: AppColors.textSub2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
