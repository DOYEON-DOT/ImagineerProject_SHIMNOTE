import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'app_icons.dart';
import 'common.dart';
import 'record_widgets.dart';

/// 어항 화면 공통 헤더: 구름 뒤 '나의 어항' + 전환 링크 + 설정(마이페이지)
class TankHeader extends StatelessWidget {
  const TankHeader({super.key, required this.linkLabel, required this.onLink});

  final String linkLabel;
  final VoidCallback onLink;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(left: -14, top: -12, child: Svg(AppIcons.cloud(), size: 168, height: 56)),
            Text('나의 어항', style: ts(17, weight: bold)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UnderlineLink(label: linkLabel, onTap: onLink),
            const SizedBox(width: 14),
            Tap(
              onTap: () => Nav.push(context, AppRoutes.myPage),
              child: Svg(AppIcons.settings(AppColors.textDark), size: 22),
            ),
          ],
        ),
      ],
    );
  }
}

/// 어항 배경 (물 그라데이션 + 모래 + 수초)
class TankBackground extends StatelessWidget {
  const TankBackground({super.key, required this.sandRatio, required this.plants});

  final double sandRatio; // 모래가 차지하는 높이 비율
  final List<PlantSpec> plants;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFCDEEF0), Color(0xFF7FC9D6)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: c.maxHeight * sandRatio,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x99F0E6BE), Color(0xFFE7DCB0)],
                ),
              ),
            ),
          ),
          // 안쪽 그림자 느낌 (inset 0 0 40px rgba(0,60,70,0.12))
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1.1,
                    colors: [Colors.transparent, AppColors.alpha(const Color(0xFF003C46), 0.12)],
                    stops: const [0.75, 1.0],
                  ),
                ),
              ),
            ),
          ),
          for (final p in plants)
            Positioned(
              left: p.left,
              right: p.right,
              bottom: p.bottom,
              child: Container(
                width: p.width,
                height: p.height,
                decoration: BoxDecoration(
                  color: p.color,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(p.width * 0.4, p.height * 0.4),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

class PlantSpec {
  const PlantSpec({this.left, this.right, required this.bottom, required this.width, required this.height, required this.color});

  final double? left;
  final double? right;
  final double bottom;
  final double width;
  final double height;
  final Color color;
}

const plantLight = Color(0xFF7BAB6F);
const plantDark = Color(0xFF6A9C60);

/// 물고기 레벨 카드
class FishLevelCard extends StatelessWidget {
  const FishLevelCard({super.key, required this.name, required this.level, required this.exp, required this.maxExp});

  final String name;
  final int level;
  final int exp;
  final int maxExp;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: ts(14, weight: bold)),
              Text('Lv. $level', style: ts(12, color: AppColors.textSub)),
            ],
          ),
          const SizedBox(height: 10),
          ProgressBar(value: exp / maxExp, color: AppColors.fishJoy, height: 8),
          const SizedBox(height: 10),
          Text('$exp / $maxExp EXP', textAlign: TextAlign.right, style: ts(11, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

/// 점선 원 테두리 (잠긴 물고기 슬롯)
class DashedCircle extends StatelessWidget {
  const DashedCircle({super.key, required this.size, required this.color, required this.fill, required this.child});

  final double size;
  final Color color;
  final Color fill;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedCirclePainter(color: color, fill: fill),
      child: SizedBox(width: size, height: size, child: Center(child: child)),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({required this.color, required this.fill});

  final Color color;
  final Color fill;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width / 2 - 1;
    canvas.drawCircle(center, r + 1, Paint()..color = fill);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    const dash = 5.0;
    const gap = 4.0;
    final circumference = 2 * math.pi * r;
    final count = (circumference / (dash + gap)).floor();
    final step = 2 * math.pi / count;
    final sweep = step * dash / (dash + gap);
    for (var i = 0; i < count; i++) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: r), i * step, sweep, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter old) => old.color != color || old.fill != fill;
}
