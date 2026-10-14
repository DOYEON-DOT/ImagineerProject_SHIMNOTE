import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

/// 2. 온보딩
/// '게스트로 시작하기' → 3. 메인(홈)
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const _steps = [
    '지친 하루, 오늘의 감정을 녹음 버튼으로 편하게 이야기해주세요',
    'AI가 당신의 목소리 속 감정을 세심하게 분석해요',
    '분석된 정서 상태를 웰니스 스코어로 한눈에 보여드려요',
    '분석 결과에 맞는 힐링 사운드를 추천해드려요',
    '꾸준한 기록과 어항 속 물고기 성장으로, 나의 변화를 직접 확인해보세요',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.mint100],
          ),
        ),
        padding: EdgeInsets.fromLTRB(28, topPad(context, 48), 28, bottomPad(context, 32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('쉼노트', style: logoStyle(20, AppColors.primary))),
            const SizedBox(height: 28),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _steps.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (context, i) => AppCard(
                  padding: const EdgeInsets.all(16),
                  radius: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: Text('${i + 1}', style: ts(14, weight: bold, color: AppColors.white)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Text(_steps[i], style: ts(14, height: 1.5))),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: '게스트로 시작하기',
              onTap: () => Nav.resetTo(context, AppRoutes.home),
              background: AppColors.white,
              foreground: AppColors.textDark,
              padding: 15,
              radius: 14,
              icon: Svg(AppIcons.user(AppColors.primary), size: 18),
              shadow: [BoxShadow(color: AppColors.alpha(Colors.black, 0.08), blurRadius: 14, offset: const Offset(0, 4))],
            ),
          ],
        ),
      ),
    );
  }
}
