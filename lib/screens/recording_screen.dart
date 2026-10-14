import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

enum _Stage { idle, recording, error }

/// 4. 감정 담기
/// - 마이크 탭 → 녹음 중 상태
/// - 녹음 완료 → 5. 분석
/// - '미리보기: 녹음 오류 상태' → 오류 상태, '다시 녹음' → 녹음 중
/// - 뒤로가기 → 3. 메인(홈)
class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> with TickerProviderStateMixin {
  _Stage _stage = _Stage.idle;
  Timer? _timer;
  int _seconds = 0;

  // '귀 기울여 듣고 있어요' ↔ '편안히 얘기해주세요' 문구 교차 (20초 주기)
  late final AnimationController _phrase;

  // 녹음 중 파형이 살짝 움직이도록
  late final AnimationController _wave;

  void _startRecording() {
    _timer?.cancel();
    setState(() {
      _stage = _Stage.recording;
      _seconds = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  void _showError() {
    _timer?.cancel();
    setState(() => _stage = _Stage.error);
  }

  Future<void> _finish() async {
    _timer?.cancel();
    await Nav.push(context, AppRoutes.analyzing);
    // 분석/결과 화면에서 돌아오면 다시 대기 상태로
    if (mounted) setState(() => _stage = _Stage.idle);
  }

  @override
  void initState() {
    super.initState();
    _phrase = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    _wave = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phrase.dispose();
    _wave.dispose();
    super.dispose();
  }

  String get _time {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.6, -1),
            end: Alignment(0.6, 1),
            colors: [AppColors.mint100, AppColors.mint300],
          ),
        ),
        padding: EdgeInsets.fromLTRB(24, topPad(context, 60), 24, bottomPad(context, 40)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrow(onTap: () => Nav.backTo(context, AppRoutes.home)),
            ),
            Expanded(
              child: switch (_stage) {
                _Stage.idle => _idle(),
                _Stage.error => _error(),
                _Stage.recording => _recording(),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _micCircle({required Color inner, double innerSize = 108, double iconSize = 36}) {
    return Container(
      width: 176,
      height: 176,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.alpha(AppColors.white, 0.45), shape: BoxShape.circle),
      child: Container(
        width: innerSize,
        height: innerSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: inner,
          shape: BoxShape.circle,
          boxShadow: inner == AppColors.primary
              ? [BoxShadow(color: AppColors.alpha(AppColors.textDark, 0.2), blurRadius: 26, offset: const Offset(0, 10))]
              : null,
        ),
        child: Svg(AppIcons.mic(AppColors.white), size: iconSize),
      ),
    );
  }

  Widget _idle() {
    return ShrinkToFit(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tap(onTap: _startRecording, child: _micCircle(inner: AppColors.primary)),
          const SizedBox(height: 28),
          Text('탭하여 녹음을 시작해요', style: ts(16, weight: bold)),
          const SizedBox(height: 6),
          Text('마이크를 눌러 오늘의 마음을 들려주세요', style: ts(12, color: AppColors.textBody)),
        ],
        ),
    );
  }

  Widget _error() {
    return ShrinkToFit(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _micCircle(inner: AppColors.textMuted),
          const SizedBox(height: 24),
          Text('녹음이 원활하게 진행되지 않았어요', style: ts(15, weight: bold)),
          const SizedBox(height: 24),
          Tap(
            onTap: _startRecording,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Svg(AppIcons.retry(AppColors.textDark), size: 16),
                const SizedBox(width: 6),
                Text('다시 녹음', style: ts(13, weight: bold)),
              ],
            ),
          ),
        ],
        ),
    );
  }

  Widget _recording() {
    const bars = [12.0, 22.0, 8.0, 18.0, 24.0, 10.0, 16.0];
    return Column(
      children: [
        Expanded(
          child: ShrinkToFit(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 문구 교차 애니메이션
                SizedBox(
                  height: 24,
                  width: 280,
                  child: AnimatedBuilder(
                    animation: _phrase,
                    builder: (context, _) {
                      final a = _phraseOpacity(_phrase.value);
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(opacity: a, child: Text('귀 기울여 듣고 있어요', style: ts(16, weight: FontWeight.w500))),
                          Opacity(opacity: 1 - a, child: Text('편안히 얘기해주세요', style: ts(16, weight: FontWeight.w500))),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: 176,
                  height: 176,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: AppColors.alpha(AppColors.white, 0.35), shape: BoxShape.circle),
                      ),
                      Container(
                        width: 136,
                        height: 136,
                        decoration: BoxDecoration(color: AppColors.alpha(AppColors.white, 0.55), shape: BoxShape.circle),
                      ),
                      Container(
                        width: 96,
                        height: 96,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: AppColors.alpha(AppColors.textDark, 0.2), blurRadius: 26, offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Svg(AppIcons.mic(AppColors.white), size: 34),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                // 파형
                SizedBox(
                  height: 24,
                  child: AnimatedBuilder(
                    animation: _wave,
                    builder: (context, _) => Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var i = 0; i < bars.length; i++) ...[
                          if (i > 0) const SizedBox(width: 5),
                          Container(
                            width: 4,
                            height: (bars[i] * (0.7 + 0.3 * math.sin(_wave.value * math.pi + i))).clamp(6.0, 24.0),
                            decoration: BoxDecoration(color: AppColors.textDark, borderRadius: BorderRadius.circular(2)),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text(_time, style: ts(13, color: AppColors.textBody)),
              ],
            ),
          ),
        ),
        InfoBanner(
          text: '소음이 있는 곳에서 녹음하면 분석이 정확하지 않을 수 있어요',
          background: AppColors.alpha(AppColors.white, 0.55),
          color: AppColors.textBody,
          alignTop: true,
        ),
        const SizedBox(height: 16),
        PrimaryButton(label: '녹음 완료', onTap: _finish, background: AppColors.textDark),
        const SizedBox(height: 12),
        Tap(
          onTap: _showError,
          child: Opacity(
            opacity: 0.6,
            child: Text('미리보기: 녹음 오류 상태',
                style: ts(11, color: AppColors.textBody, decoration: TextDecoration.underline)),
          ),
        ),
      ],
    );
  }

  /// CSS keyframes phraseA: 0~45% 보임, 45~55% 사라짐, 95~100% 다시 나타남
  double _phraseOpacity(double t) {
    if (t < 0.45) return 1;
    if (t < 0.55) return 1 - (t - 0.45) / 0.10;
    if (t < 0.95) return 0;
    return (t - 0.95) / 0.05;
  }
}
