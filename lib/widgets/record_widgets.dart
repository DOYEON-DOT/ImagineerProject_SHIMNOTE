import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'common.dart';

/// 기록 화면들에서 함께 쓰는 위젯 (달력, 필사 목록)

/// 2026년 9월 달력 (목업과 동일: 8월 31일 ~ 9월 20일, 17일 선택)
class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key, this.recordedDays = const {}, this.selectedDay = 17});

  /// 기록 점(•)이 찍히는 날짜
  final Set<int> recordedDays;
  final int selectedDay;

  static const _weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  @override
  Widget build(BuildContext context) {
    final days = <int>[31, for (var d = 1; d <= 20; d++) d];
    final rows = <List<int>>[];
    for (var i = 0; i < days.length; i += 7) {
      rows.add(days.sublist(i, i + 7));
    }

    return Column(
      children: [
        Row(
          children: [
            for (final w in _weekdays)
              Expanded(
                child: Text(w,
                    textAlign: TextAlign.center,
                    style: ts(11, weight: bold, color: AppColors.weekday)),
              ),
          ],
        ),
        for (var r = 0; r < rows.length; r++) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              for (var c = 0; c < 7; c++)
                Expanded(child: _day(rows[r][c], isPrevMonth: r == 0 && c == 0)),
            ],
          ),
        ],
      ],
    );
  }

  Widget _day(int day, {required bool isPrevMonth}) {
    if (!isPrevMonth && day == selectedDay) {
      return SizedBox(
        height: 40,
        child: Center(
          child: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: Text('$day', style: ts(13, weight: bold, color: AppColors.white)),
          ),
        ),
      );
    }
    final hasDot = !isPrevMonth && recordedDays.contains(day);
    return SizedBox(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$day', style: ts(13, color: isPrevMonth ? AppColors.dayOff : AppColors.textDark)),
          if (hasDot) ...[
            const SizedBox(height: 2),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
          ],
        ],
      ),
    );
  }
}

/// 필사 데이터 (목업 예시)
class TranscriptItem {
  const TranscriptItem(this.no, this.date, this.text);

  final int no;
  final String date;
  final String text;
}

const sampleTranscripts = [
  TranscriptItem(12, '2026.09.17', '천천히 걸어도 괜찮아요. 방향이 맞다면...'),
  TranscriptItem(11, '2026.09.15', '잘 자라는 나무는 천천히 자란다'),
  TranscriptItem(10, '2026.09.14', '오늘의 나에게 조금 더 다정하게'),
  TranscriptItem(9, '2026.09.12', '쉬어가는 것도 나아가는 방법이에요'),
];

/// 필사 목록 카드
class TranscriptTile extends StatelessWidget {
  const TranscriptTile({super.key, required this.item});

  final TranscriptItem item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: const Color(0xFFEEF7EC), borderRadius: BorderRadius.circular(12)),
            child: Text('${item.no}', style: ts(12, weight: bold, color: AppColors.clover)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.date, style: ts(11, color: AppColors.textMuted)),
                const SizedBox(height: 3),
                Text(item.text, maxLines: 1, overflow: TextOverflow.ellipsis, style: ts(13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 필사 목록 (카드 사이 간격 12)
class TranscriptList extends StatelessWidget {
  const TranscriptList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < sampleTranscripts.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          TranscriptTile(item: sampleTranscripts[i]),
        ],
      ],
    );
  }
}

/// 화면 오른쪽 위 '첫 사용자 화면 보기' 같은 밑줄 링크
class UnderlineLink extends StatelessWidget {
  const UnderlineLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Text(label,
          style: ts(11, color: AppColors.textSub, decoration: TextDecoration.underline)),
    );
  }
}
