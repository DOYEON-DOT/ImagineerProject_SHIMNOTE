import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

/// 11. 마이페이지
/// - 뒤로가기 → 10. 어항
/// - 데이터 초기화 → 안내 패널 열기/닫기
class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  bool _showWithdraw = false;

  void _toggle() => setState(() => _showWithdraw = !_showWithdraw);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, bottomPad(context, 32)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CenterTitleHeader(
              title: '마이페이지',
              onBack: () => Nav.backTo(context, AppRoutes.fishTank),
            ),
            const SizedBox(height: 28),
            _profile(),
            const SizedBox(height: 24),
            _sectionTitle('데이터 관리'),
            AppCard(
              radius: 16,
              padding: EdgeInsets.zero,
              child: _row(
                label: '데이터 초기화',
                labelColor: AppColors.danger,
                trailing: Svg(AppIcons.chevronRight(AppColors.textMuted), size: 16),
                onTap: _toggle,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: _showWithdraw
                  ? Padding(padding: const EdgeInsets.only(top: 12), child: _withdrawPanel())
                  : const SizedBox(width: double.infinity, height: 22),
            ),
            _sectionTitle('앱 정보'),
            AppCard(
              radius: 16,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _row(label: '버전 정보', trailing: Text('v1.0.0', style: ts(13, color: AppColors.textMuted))),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F6F4)),
                  _row(
                    label: '문의하기',
                    trailing: Svg(AppIcons.chevronRight(AppColors.textMuted), size: 16),
                    onTap: () => showMockSnack(context, '문의하기는 준비 중이에요'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Color(0xFFCDEEE5), shape: BoxShape.circle),
            child: Svg(AppIcons.user(AppColors.primary), size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('게스트', style: ts(15, weight: bold)),
                const SizedBox(height: 2),
                Text('이 기기에 기록이 저장돼요', style: ts(12, color: AppColors.textSub)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.track, borderRadius: BorderRadius.circular(999)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Svg(AppIcons.info(AppColors.textInfo, width: 1.8), size: 11),
                      const SizedBox(width: 4),
                      Text('앱 삭제 시 기록이 사라질 수 있어요', style: ts(10, color: AppColors.textInfo)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(text, style: ts(12, weight: bold, color: AppColors.textSub)),
      );

  Widget _row({required String label, Color labelColor = AppColors.textDark, required Widget trailing, VoidCallback? onTap}) {
    return Tap(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label, style: ts(14, color: labelColor)), trailing],
        ),
      ),
    );
  }

  Widget _withdrawPanel() {
    Widget button(String label, Color bg, Color fg, VoidCallback onTap) => Expanded(
          child: Tap(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
              child: Text(label, style: ts(13, weight: bold, color: fg)),
            ),
          ),
        );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFFFDF1EE), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('초기화 전 안내', style: ts(13, weight: bold, color: const Color(0xFFA44A3A))),
          const SizedBox(height: 8),
          Text(
            '초기화하면 기록, 웰니스 스코어, 어항 상태 등 저장된 모든 데이터가 즉시 삭제되며 복구할 수 없어요.',
            style: ts(12, color: const Color(0xFF7A4A3F), height: 1.6),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              button('취소', AppColors.white, AppColors.textDark, _toggle),
              const SizedBox(width: 10),
              button('초기화하기', AppColors.danger, AppColors.white, () {
                _toggle();
                showMockSnack(context, '데이터를 초기화했어요 (목업)');
              }),
            ],
          ),
        ],
      ),
    );
  }
}
