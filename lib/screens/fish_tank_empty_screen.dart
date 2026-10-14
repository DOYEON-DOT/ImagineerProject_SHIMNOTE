import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../widgets/app_icons.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';
import '../widgets/fish_widgets.dart';

/// 10-1. 어항(첫 사용자)
/// - '성장한 화면 보기' → 10. 어항
/// - 설정 아이콘 → 11. 마이페이지
class FishTankEmptyScreen extends StatelessWidget {
  const FishTankEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TankHeader(
                    linkLabel: '성장한 화면 보기',
                    onLink: () => Nav.replace(context, AppRoutes.fishTank),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: 280,
                      child: LayoutBuilder(builder: (context, c) {
                        return Stack(
                          children: [
                            const Positioned.fill(
                              child: TankBackground(
                                sandRatio: 0.3,
                                plants: [
                                  PlantSpec(left: 20, bottom: 12, width: 14, height: 22, color: plantLight),
                                  PlantSpec(right: 24, bottom: 12, width: 12, height: 18, color: plantDark),
                                ],
                              ),
                            ),
                            Positioned(
                              left: c.maxWidth * 0.40,
                              top: c.maxHeight * 0.46,
                              child: Svg(AppIcons.fish(AppColors.fishJoy, smile: true), size: 40, height: 26),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const FishLevelCard(name: '기쁨 물고기', level: 1, exp: 1, maxExp: 10),
                  const SizedBox(height: 22),
                  const InfoBanner(text: '감정을 기록할수록 물고기가 자라고, 새로운 친구가 해금돼요'),
                ],
              ),
            ),
          ),
          const AppBottomNav(current: NavTab.fishTank),
        ],
      ),
    );
  }
}
