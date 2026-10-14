import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';

/// 3. 메인(홈)
/// - 하루 기록하기 카드 → 4. 감정 담기
/// - 작은 행운 만나기 → 3-1. 작은 행운
/// - 하단 탭: 기록 → 9. 기록, 어항 → 10. 어항
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'GOOD MORNING';
    if (hour < 18) return 'GOOD AFTERNOON';
    return 'GOOD EVENING';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Positioned(top: -70, right: -70, child: BubbleDeco(size: 200)),
                const Positioned(top: 130, left: -60, child: BubbleDeco(size: 120, opacity: 0.7)),
                FillScrollView(
                  padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, 20),
                  children: [
                    Text(_greeting(),
                        style: ts(12, weight: bold, color: AppColors.accent, letterSpacing: 1)),
                    const SizedBox(height: 10),
                    Text('오늘 하루도\n참 수고 많으셨어요', style: ts(20, weight: bold, height: 1.4)),
                    const SizedBox(height: 24),
                    _RecordCard(onTap: () => Nav.push(context, AppRoutes.recording)),
                    const SizedBox(height: 18),
                    _LuckyCard(onTap: () => Nav.push(context, AppRoutes.lucky)),
                    const SizedBox(height: 18),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.alpha(AppColors.white, 0.6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Svg(AppIcons.flame(), size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text('오늘도 목소리로 마음을 기록하면, 어항의 물고기가 자라나요',
                                style: ts(12, color: AppColors.textInfo)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const AppBottomNav(current: NavTab.home),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: AppCard(
        radius: 24,
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
        shadow: AppColors.cardShadow(0.10, 20, 6),
        child: Column(
          children: [
            Container(
              width: 132,
              height: 132,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [AppColors.white, AppColors.mint100, AppColors.mint200],
                  stops: [0.0, 0.7, 1.0],
                ),
                boxShadow: AppColors.cardShadow(0.22, 30, 10),
              ),
              child: Container(
                width: 78,
                height: 78,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: Svg(AppIcons.mic(AppColors.white), size: 30),
              ),
            ),
            const SizedBox(height: 14),
            Text('하루 기록하기', style: ts(16, weight: bold)),
            const SizedBox(height: 4),
            Text('이 감정을 목소리로 남겨보세요', style: ts(12, color: AppColors.textSub)),
            const SizedBox(height: 16),
            Text('탭하여 시작해요 ↑', style: ts(11, color: AppColors.textFaint)),
          ],
        ),
      ),
    );
  }
}

class _LuckyCard extends StatelessWidget {
  const _LuckyCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: AppCard(
        radius: 20,
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F5D9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Svg(AppIcons.clover(), size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('작은 행운 만나기', style: ts(14, weight: bold)),
                  const SizedBox(height: 3),
                  Text('나를 위한 한 마디와 필사하기', style: ts(12, color: AppColors.textSub, height: 1.4)),
                  const SizedBox(height: 6),
                  Text('탭하여 열어보기', style: ts(11, weight: bold, color: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Svg(AppIcons.chevronRight(AppColors.primary), size: 18),
          ],
        ),
      ),
    );
  }
}
