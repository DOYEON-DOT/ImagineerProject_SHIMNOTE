import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

/// 6. 웰니스 스코어
/// - 뒤로가기 → 4. 감정 담기
/// - 추천 사운드 듣기 → 7. 사운드 추천
class WellnessScoreScreen extends StatelessWidget {
  const WellnessScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FillScrollView(
        padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, bottomPad(context, 32)),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: BackArrow(onTap: () => Nav.backTo(context, AppRoutes.recording)),
          ),
          const SizedBox(height: 24),
          _scoreCard(),
          const SizedBox(height: 16),
          _sourceCard(),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(child: _MiniStat(label: '활력', value: 0.41, color: AppColors.orange)),
              SizedBox(width: 12),
              Expanded(child: _MiniStat(label: '안정', value: 0.76, color: AppColors.mintBar)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _MiniStat(label: '불안', value: 0.24, color: AppColors.coral)),
              SizedBox(width: 12),
              Expanded(child: _MiniStat(label: '피로', value: 0.32, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 16),
          const Spacer(),
          PrimaryButton(
            label: '추천 사운드 듣기',
            onTap: () => Nav.push(context, AppRoutes.soundRecommend),
          ),
        ],
      ),
    );
  }

  Widget _scoreCard() {
    return AppCard(
      radius: 22,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      shadow: AppColors.cardShadow(0.10, 24, 8),
      child: Column(
        children: [
          Text('WELLNESS SCORE', style: ts(12, weight: bold, color: AppColors.textSub, letterSpacing: 2)),
          const SizedBox(height: 8),
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(color: Color(0xFFF2FBF8), shape: BoxShape.circle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('72', style: ts(34, weight: bold, height: 1.2)),
                Text('/ 100', style: ts(11, color: AppColors.textSub)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text('편안하고 안정된 상태예요', style: ts(15, weight: bold)),
          const SizedBox(height: 20),
          const Divider(height: 1, thickness: 1, color: AppColors.track),
          const SizedBox(height: 20),
          const _EmotionRow(label: '긍정', value: 0.68, color: AppColors.primary),
          const SizedBox(height: 14),
          const _EmotionRow(label: '안정', value: 0.76, color: AppColors.mintBar),
          const SizedBox(height: 14),
          const _EmotionRow(label: '부정', value: 0.24, color: AppColors.coral),
        ],
      ),
    );
  }

  Widget _sourceCard() {
    return AppCard(
      color: const Color(0xFFFDF6E8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      shadow: AppColors.cardShadow(0.06),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: const Color(0xFFF6E6BF), borderRadius: BorderRadius.circular(12)),
            child: Svg(AppIcons.document(), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text("이 점수는 주로\n'일/학업' 영역에서 나온 감정이에요",
                style: ts(14, weight: bold, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _EmotionRow extends StatelessWidget {
  const _EmotionRow({required this.label, required this.value, required this.color});

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 46, child: Text(label, style: ts(13))),
        const SizedBox(width: 10),
        Expanded(child: ProgressBar(value: value, color: color)),
        const SizedBox(width: 10),
        SizedBox(
          width: 34,
          child: Text('${(value * 100).round()}%',
              textAlign: TextAlign.right, style: ts(13, color: AppColors.textSub)),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.color});

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      radius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: ts(12, color: AppColors.textSub)),
          const SizedBox(height: 6),
          Text('${(value * 100).round()}%', style: ts(20, weight: bold)),
          const SizedBox(height: 8),
          ProgressBar(value: value, color: color, height: 6, radius: 4),
        ],
      ),
    );
  }
}
