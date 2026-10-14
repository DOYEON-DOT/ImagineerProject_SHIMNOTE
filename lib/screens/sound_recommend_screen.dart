import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';

/// 7. 사운드 추천
/// - 뒤로가기 → 6. 웰니스 스코어
/// - 추천 사운드 / 다른 사운드 카드 → 8. 사운드 재생
/// - 하단 탭: 홈 / 기록 / 어항
class SoundRecommendScreen extends StatelessWidget {
  const SoundRecommendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void play() => Nav.push(context, AppRoutes.soundPlay);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackArrow(onTap: () => Nav.backTo(context, AppRoutes.wellness)),
                  const SizedBox(height: 24),
                  Text('FOR YOUR MOOD',
                      style: ts(12, weight: bold, color: AppColors.primary, letterSpacing: 1)),
                  const SizedBox(height: 6),
                  Text('오늘의 감정에 맞는\n사운드예요', style: ts(19, weight: bold, height: 1.4)),
                  const SizedBox(height: 28),
                  _FeaturedSound(onTap: play),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text('이런 소리도 있어요', style: ts(12, color: AppColors.textSub)),
                  ),
                  const SizedBox(height: 10),
                  _SoundTile(
                    title: '게임 속 작은 세상',
                    desc: '통통 튀는 게임 속 분위기의 사운드',
                    iconBg: const Color(0xFFDFE8EE),
                    icon: Svg(AppIcons.gamepad(), size: 24),
                    onTap: play,
                  ),
                  const SizedBox(height: 12),
                  _SoundTile(
                    title: '맑은 샘물 소리',
                    desc: '바위 사이로 흐르는 맑은 샘물 소리',
                    iconBg: const Color(0xFFDCEBFB),
                    icon: Svg(AppIcons.drop(const Color(0xFF3A7BD5)), size: 24),
                    onTap: play,
                  ),
                ],
              ),
            ),
          ),
          const AppBottomNav(current: NavTab.none),
        ],
      ),
    );
  }
}

class _FeaturedSound extends StatelessWidget {
  const _FeaturedSound({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: AppCard(
        color: AppColors.primaryDark,
        radius: 22,
        padding: const EdgeInsets.all(20),
        shadow: [
          BoxShadow(color: AppColors.alpha(AppColors.primaryDark, 0.25), blurRadius: 20, offset: const Offset(0, 8)),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.alpha(AppColors.white, 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Svg(AppIcons.music(AppColors.white), size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.alpha(AppColors.white, 0.22),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text('추천 사운드', style: ts(10, color: AppColors.white)),
                      ),
                      const SizedBox(height: 6),
                      Text('물빛의 잔향', style: ts(17, weight: bold, color: AppColors.white)),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                  child: Svg(AppIcons.play(AppColors.primaryDark), size: 18),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text('물속에 번지는 맑은 건반 사운드',
                style: ts(12, color: AppColors.alpha(AppColors.white, 0.9))),
          ],
        ),
      ),
    );
  }
}

class _SoundTile extends StatelessWidget {
  const _SoundTile({
    required this.title,
    required this.desc,
    required this.iconBg,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String desc;
  final Color iconBg;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)),
              child: icon,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: ts(14, weight: bold)),
                  const SizedBox(height: 2),
                  Text(desc, style: ts(12, color: AppColors.textSub)),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: Svg(AppIcons.play(AppColors.white), size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
