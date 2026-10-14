import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';
import '../widgets/record_widgets.dart';

/// 9. 기록
/// - 캘린더 / 필사 탭 전환 (작은 행운에서 필사를 저장하면 필사 탭으로 열림)
/// - 오늘의 메모 영역 → 9-2. 오늘의 메모
/// - '첫 사용자 화면 보기' → 9-1. 기록(첫 사용자)
/// - 하단 탭: 홈 / 어항
class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key, this.showTranscripts = false});

  /// true면 '필사' 탭이 선택된 상태로 열립니다. (작은 행운 → 필사 저장하기)
  final bool showTranscripts;

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  late bool _calendar = !widget.showTranscripts;

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
                      Text('나의 기록', style: ts(17, weight: bold)),
                      UnderlineLink(
                        label: '첫 사용자 화면 보기',
                        onTap: () => Nav.replace(context, AppRoutes.recordsEmpty),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _segment(),
                  const SizedBox(height: 20),
                  if (_calendar) _calendarTab() else const TranscriptList(),
                ],
              ),
            ),
          ),
          const AppBottomNav(current: NavTab.records),
        ],
      ),
    );
  }

  Widget _segment() {
    Widget item(String label, bool active, VoidCallback onTap) => Expanded(
          child: Tap(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: ts(13, weight: bold, color: active ? AppColors.white : AppColors.textSub)),
            ),
          ),
        );

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: AppColors.cardShadow(0.06),
      ),
      child: Row(
        children: [
          item('캘린더', _calendar, () => setState(() => _calendar = true)),
          item('필사', !_calendar, () => setState(() => _calendar = false)),
        ],
      ),
    );
  }

  Widget _calendarTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 연속 기록 배너
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(color: const Color(0xFFFFF2D6), borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: const Color(0xFFFFE3AC), borderRadius: BorderRadius.circular(14)),
                child: Svg(AppIcons.streakFlame(), size: 22),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('3일째 연속 기록 중', style: ts(15, weight: bold, color: const Color(0xFF8A5B0F))),
                  const SizedBox(height: 2),
                  Text('이대로 쭉 이어가 볼까요?', style: ts(12, color: const Color(0xFFA97D33))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const MonthCalendar(recordedDays: {2, 3, 4}),
        const SizedBox(height: 20),
        // 선택한 날짜 상세
        AppCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('9월 17일', style: ts(13, weight: bold)),
              const SizedBox(height: 14),
              _kv('웰니스 스코어', Text('72점', style: ts(14, weight: bold, color: AppColors.primary))),
              const SizedBox(height: 14),
              _kv('들었던 사운드', Text('잔잔한 빗소리', style: ts(13))),
              const SizedBox(height: 14),
              Tap(
                onTap: () => Nav.push(context, AppRoutes.recordMemo),
                child: Container(
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.track))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('오늘의 메모', style: ts(12, color: AppColors.textSub)),
                          Svg(AppIcons.pencil(AppColors.textMuted), size: 14),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('과제 마감 때문에 지쳤지만, 소리를 듣고 나니 마음이 좀 편안해졌다.',
                          style: ts(13, height: 1.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        AppCard(
          radius: 16,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('이번 주 영역별 리포트', style: ts(13, weight: bold)),
              Text('데이터가 쌓이면 열려요', style: ts(12, color: AppColors.textMuted)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kv(String key, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(key, style: ts(12, color: AppColors.textSub)), value],
    );
  }
}
