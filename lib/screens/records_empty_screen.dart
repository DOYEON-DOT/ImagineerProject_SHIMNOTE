import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';
import '../widgets/record_widgets.dart';

/// 9-1. 기록(첫 사용자)
/// - '기록 있는 화면 보기' → 9. 기록
/// - 감정 담으러 가기 → 3. 메인(홈)
class RecordsEmptyScreen extends StatelessWidget {
  const RecordsEmptyScreen({super.key});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2026년 9월', style: ts(17, weight: bold)),
                      UnderlineLink(
                        label: '기록 있는 화면 보기',
                        onTap: () => Nav.replace(context, AppRoutes.records),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const MonthCalendar(),
                  const SizedBox(height: 24),
                  AppCard(
                    radius: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(color: Color(0xFFEAF6F2), shape: BoxShape.circle),
                          child: Svg(AppIcons.calendar(const Color(0xFF7FB0A8), width: 1.8), size: 28),
                        ),
                        const SizedBox(height: 16),
                        Text('아직 기록이 없어요', style: ts(15, weight: bold)),
                        const SizedBox(height: 6),
                        Text('오늘의 감정을 담아보면\n이곳에 하루하루가 쌓여요',
                            textAlign: TextAlign.center,
                            style: ts(12, color: AppColors.textSub, height: 1.5)),
                        const SizedBox(height: 16),
                        Tap(
                          onTap: () => Nav.resetTo(context, AppRoutes.home),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('감정 담으러 가기', style: ts(13, weight: bold, color: AppColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AppBottomNav(current: NavTab.records),
        ],
      ),
    );
  }
}
