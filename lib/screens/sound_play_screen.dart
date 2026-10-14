import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/animations.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

/// 8. 사운드 재생
/// - 뒤로가기 → 7. 사운드 추천
/// - 재생/일시정지 토글, 힐링 타이머 카운트다운
/// - 힐링 종료 → 3. 메인(홈)
class SoundPlayScreen extends StatefulWidget {
  const SoundPlayScreen({super.key});

  @override
  State<SoundPlayScreen> createState() => _SoundPlayScreenState();
}

class _SoundPlayScreenState extends State<SoundPlayScreen> {
  bool _playing = true;
  int _remain = 6 * 60 + 28; // 6분 28초
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_playing || _remain <= 0) return;
      setState(() => _remain--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _remainText => '${_remain ~/ 60}분 ${_remain % 60}초 남음';

  @override
  Widget build(BuildContext context) {
    const light = Color(0xFFCFE6E2);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.6, -1),
              end: Alignment(0.6, 1),
              colors: [Color(0xFF1D3F3C), Color(0xFF0F2624)],
            ),
          ),
          padding: EdgeInsets.fromLTRB(24, topPad(context, 28), 24, bottomPad(context, 44)),
          child: Column(
            children: [
              CenterTitleHeader(
                title: '힐링 중',
                color: AppColors.white,
                fontSize: 15,
                backSize: 22,
                onBack: () => Nav.backTo(context, AppRoutes.soundRecommend),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.alpha(AppColors.white, 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Svg(AppIcons.clock(light), size: 14),
                    const SizedBox(width: 6),
                    Text('힐링 타이머', style: ts(12, color: light)),
                    const Spacer(),
                    Text(_remainText, style: ts(13, weight: bold, color: AppColors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ShrinkToFit(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 270,
                        height: 270,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            if (_playing)
                              RippleRings(
                                ringSize: 210,
                                color: AppColors.alpha(AppColors.white, 0.35),
                                duration: const Duration(milliseconds: 3200),
                                scaleFrom: 0.75,
                                scaleTo: 1.9,
                                opacityFrom: 0.5,
                              ),
                            Container(
                              width: 160,
                              height: 160,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.alpha(AppColors.white, 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 110,
                                height: 110,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.alpha(AppColors.white, 0.16),
                                  shape: BoxShape.circle,
                                ),
                                child: Svg(AppIcons.drop(AppColors.white), size: 60),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text('잔잔한 빗소리', style: ts(18, weight: bold, color: AppColors.white)),
                      const SizedBox(height: 6),
                      Text('숨을 천천히 내쉬어 보세요', style: ts(13, color: const Color(0xFFB9D4CF))),
                      const SizedBox(height: 26),
                      Svg(AppIcons.waveLine(AppColors.alpha(AppColors.white, 0.35)), size: 140, height: 24),
                      const SizedBox(height: 26),
                      Tap(
                        onTap: () => setState(() => _playing = !_playing),
                        child: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.alpha(AppColors.white, 0.14),
                            shape: BoxShape.circle,
                          ),
                          child: Svg(
                            _playing ? AppIcons.pause(AppColors.white) : AppIcons.play(AppColors.white),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Tap(
                onTap: () => Nav.resetTo(context, AppRoutes.home),
                child: Text('힐링 종료',
                    style: ts(13, weight: bold, color: light, decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
