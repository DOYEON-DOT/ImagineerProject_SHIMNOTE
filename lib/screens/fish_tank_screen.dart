import 'dart:async';

import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';
import '../widgets/fish_widgets.dart';

/// 10. 어항
/// - 물고기를 탭하면 커졌다 작아지고 하트가 떠오르며 이름표가 보입니다
/// - 잠긴 물고기(슬픔/분노)를 탭하면 해금 조건 안내
/// - '첫 사용자 화면 보기' → 10-1. 어항(첫 사용자)
/// - 설정 아이콘 → 11. 마이페이지
class FishTankScreen extends StatefulWidget {
  const FishTankScreen({super.key});

  @override
  State<FishTankScreen> createState() => _FishTankScreenState();
}

class _FishTankScreenState extends State<FishTankScreen> with TickerProviderStateMixin {
  static const _labels = {'joy': '기쁨 물고기 · Lv.3', 'calm': '안정 물고기 · Lv.1'};
  static const _tips = {'sad': '슬픈 감정을 기록하면 해금돼요', 'anger': '화난 감정을 기록하면 해금돼요'};

  String? _selected;
  String? _pulse;
  String? _tip;

  late final AnimationController _joySwim;
  late final AnimationController _calmSwim;
  late final AnimationController _joyHeart;
  late final AnimationController _calmHeart;

  void _pick(String id) {
    setState(() {
      _selected = id;
      _pulse = id;
    });
    (id == 'joy' ? _joyHeart : _calmHeart).forward(from: 0);
    Timer(const Duration(milliseconds: 220), () {
      if (mounted && _pulse == id) setState(() => _pulse = null);
    });
  }

  @override
  void initState() {
    super.initState();
    _joySwim = AnimationController(vsync: this, duration: const Duration(seconds: 9))..repeat();
    _calmSwim = AnimationController(vsync: this, duration: const Duration(seconds: 7))..repeat();
    _joyHeart = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _calmHeart = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  }

  @override
  void dispose() {
    _joySwim.dispose();
    _calmSwim.dispose();
    _joyHeart.dispose();
    _calmHeart.dispose();
    super.dispose();
  }

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
                    linkLabel: '첫 사용자 화면 보기',
                    onLink: () => Nav.replace(context, AppRoutes.fishTankEmpty),
                  ),
                  const SizedBox(height: 24),
                  _tank(),
                  const SizedBox(height: 14),
                  Text('물고기를 탭해보세요', style: ts(11, color: AppColors.textSub)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('보유한 물고기', style: ts(14, weight: bold)),
                      Text('4마리 중 2마리 해금', style: ts(12, color: AppColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ownedFish(),
                  const SizedBox(height: 22),
                  if (_tip != null) ...[
                    InfoBanner(text: _tips[_tip]!, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                    const SizedBox(height: 22),
                  ],
                  const FishLevelCard(name: '기쁨 물고기', level: 3, exp: 25, maxExp: 45),
                ],
              ),
            ),
          ),
          const AppBottomNav(current: NavTab.fishTank),
        ],
      ),
    );
  }

  Widget _tank() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 280,
        child: LayoutBuilder(builder: (context, c) {
          final w = c.maxWidth;
          final h = c.maxHeight;
          return Stack(
            children: [
              const Positioned.fill(
                child: TankBackground(
                  sandRatio: 0.4,
                  plants: [
                    PlantSpec(left: 16, bottom: 16, width: 20, height: 34, color: plantLight),
                    PlantSpec(left: 44, bottom: 16, width: 16, height: 24, color: plantDark),
                    PlantSpec(right: 30, bottom: 16, width: 18, height: 30, color: plantLight),
                  ],
                ),
              ),
              Positioned(
                left: w * 0.26,
                top: h * 0.38,
                child: _SwimmingFish(
                  swim: _joySwim,
                  heart: _joyHeart,
                  distance: 92,
                  startFlip: 1,
                  width: 46,
                  height: 30,
                  heartLeft: 13,
                  pulsing: _pulse == 'joy',
                  svg: AppIcons.fish(AppColors.fishJoy, smile: true),
                  onTap: () => _pick('joy'),
                ),
              ),
              Positioned(
                left: w * 0.58,
                top: h * 0.58,
                child: _SwimmingFish(
                  swim: _calmSwim,
                  heart: _calmHeart,
                  distance: -68,
                  startFlip: -1,
                  width: 34,
                  height: 22,
                  heartLeft: 8,
                  pulsing: _pulse == 'calm',
                  svg: AppIcons.fish(AppColors.fishCalm),
                  onTap: () => _pick('calm'),
                ),
              ),
              if (_selected != null)
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.alpha(AppColors.white, 0.92),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(color: AppColors.alpha(Colors.black, 0.08), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Text(_labels[_selected]!, style: ts(12, weight: bold)),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _ownedFish() {
    Widget slot({required Widget circle, required String name, required String sub, required bool unlocked, required VoidCallback onTap}) {
      return Tap(
        onTap: onTap,
        child: Column(
          children: [
            circle,
            const SizedBox(height: 6),
            Text(name, style: ts(11, weight: unlocked ? bold : FontWeight.w400, color: unlocked ? AppColors.textDark : AppColors.locked)),
            const SizedBox(height: 6),
            Text(sub, style: ts(10, color: unlocked ? AppColors.textMuted : AppColors.lockedBorder)),
          ],
        ),
      );
    }

    Widget owned(Color bg, Color border, Widget fish) => Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle, border: Border.all(color: border, width: 2)),
          child: fish,
        );

    final locked = DashedCircle(
      size: 60,
      color: AppColors.lockedBorder,
      fill: const Color(0xFFEEF3F2),
      child: Svg(AppIcons.lock(AppColors.locked), size: 20),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          slot(
            circle: owned(const Color(0xFFFFE7C9), AppColors.fishJoy,
                Svg(AppIcons.fish(AppColors.fishJoy, smile: true), size: 30, height: 20)),
            name: '기쁨',
            sub: 'Lv.3',
            unlocked: true,
            onTap: () => _pick('joy'),
          ),
          const SizedBox(width: 14),
          slot(
            circle: owned(
              const Color(0xFFDFF3F7),
              AppColors.fishCalm,
              Transform.flip(flipX: true, child: Svg(AppIcons.fish(AppColors.fishCalm), size: 30, height: 20)),
            ),
            name: '안정',
            sub: 'Lv.1',
            unlocked: true,
            onTap: () => _pick('calm'),
          ),
          const SizedBox(width: 14),
          slot(circle: locked, name: '슬픔', sub: '미해금', unlocked: false, onTap: () => setState(() => _tip = 'sad')),
          const SizedBox(width: 14),
          slot(circle: locked, name: '분노', sub: '미해금', unlocked: false, onTap: () => setState(() => _tip = 'anger')),
        ],
      ),
    );
  }
}

/// 좌우로 헤엄치는 물고기 (목업 keyframes swimJoy / swimCalm 재현)
class _SwimmingFish extends StatelessWidget {
  const _SwimmingFish({
    required this.swim,
    required this.heart,
    required this.distance,
    required this.startFlip,
    required this.width,
    required this.height,
    required this.heartLeft,
    required this.pulsing,
    required this.svg,
    required this.onTap,
  });

  final Animation<double> swim;
  final AnimationController heart;
  final double distance;
  final double startFlip;
  final double width;
  final double height;
  final double heartLeft;
  final bool pulsing;
  final String svg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([swim, heart]),
      builder: (context, _) {
        final (x, flip) = _swimAt(swim.value);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(x, 0, 0)..multiply(Matrix4.diagonal3Values(flip, 1, 1)),
          child: Tap(
            onTap: onTap,
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedScale(
                    scale: pulsing ? 1.35 : 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                    child: Svg(svg, size: width, height: height),
                  ),
                  if (heart.isAnimating) _heart(heart.value),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _heart(double t) {
    // keyframes heartFloat: 0% / 50% / 80% / 100%
    double lerp3(double a, double b, double c, double d) {
      if (t < 0.5) return a + (b - a) * (t / 0.5);
      if (t < 0.8) return b + (c - b) * ((t - 0.5) / 0.3);
      return c + (d - c) * ((t - 0.8) / 0.2);
    }

    final opacity = lerp3(0.9, 1, 0.9, 0);
    final dy = lerp3(0, -16, -24, -28);
    final scale = lerp3(0.4, 1, 1.05, 1.6);
    return Positioned(
      top: -18,
      left: heartLeft,
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy),
          child: Transform.scale(scale: scale, child: Svg(AppIcons.heart(), size: 18)),
        ),
      ),
    );
  }

  /// t(0~1) 시점의 x 이동량과 좌우 방향(scaleX)
  (double, double) _swimAt(double t) {
    final ease = Curves.easeInOut;
    if (t < 0.45) return (distance * ease.transform(t / 0.45), startFlip);
    if (t < 0.50) {
      final k = ease.transform((t - 0.45) / 0.05);
      return (distance, startFlip + (-2 * startFlip) * k);
    }
    if (t < 0.95) return (distance * (1 - ease.transform((t - 0.5) / 0.45)), -startFlip);
    final k = ease.transform((t - 0.95) / 0.05);
    return (0, -startFlip + (2 * startFlip) * k);
  }
}
