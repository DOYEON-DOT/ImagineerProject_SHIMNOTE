import 'dart:math' as math;

import 'package:flutter/material.dart';

/// 목업의 퍼져나가는 원(ripple) 애니메이션
/// (5. 분석: analyzeRipple / 8. 사운드 재생: ripple)
class RippleRings extends StatefulWidget {
  const RippleRings({
    super.key,
    required this.ringSize,
    required this.color,
    required this.duration,
    this.count = 3,
    this.scaleFrom = 0.7,
    this.scaleTo = 2.1,
    this.opacityFrom = 0.55,
  });

  final double ringSize;
  final Color color;
  final Duration duration;
  final int count;
  final double scaleFrom;
  final double scaleTo;
  final double opacityFrom;

  @override
  State<RippleRings> createState() => _RippleRingsState();
}

class _RippleRingsState extends State<RippleRings> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: List.generate(widget.count, (i) {
            // 각 원은 1/count 만큼 늦게 시작합니다 (animation-delay)
            final t = (_c.value + (widget.count - i) / widget.count) % 1.0;
            final eased = Curves.easeOut.transform(t);
            final scale = widget.scaleFrom + (widget.scaleTo - widget.scaleFrom) * eased;
            final opacity = widget.opacityFrom * (1 - eased);
            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Container(
                  width: widget.ringSize,
                  height: widget.ringSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: widget.color, width: 1.5),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

/// 위아래로 살짝 통통 튀는 애니메이션 (5. 분석: dropBounce)
class Bounce extends StatefulWidget {
  const Bounce({super.key, required this.child, this.distance = 5, this.duration = const Duration(milliseconds: 1600)});

  final Widget child;
  final double distance;
  final Duration duration;

  @override
  State<Bounce> createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      builder: (context, child) {
        final y = (1 - math.cos(_c.value * 2 * math.pi)) / 2 * widget.distance;
        return Transform.translate(offset: Offset(0, y), child: child);
      },
    );
  }
}
