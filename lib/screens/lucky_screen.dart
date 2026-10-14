import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/app_icons.dart';
import '../widgets/common.dart';

/// 3-1. 작은 행운
/// - 뒤로가기 → 3. 메인(홈)
/// - 필사 저장하기 → 9. 기록 (필사 탭이 선택된 상태)
class LuckyScreen extends StatefulWidget {
  const LuckyScreen({super.key});

  @override
  State<LuckyScreen> createState() => _LuckyScreenState();
}

class _LuckyScreenState extends State<LuckyScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cloverShadow = [
      BoxShadow(color: AppColors.alpha(AppColors.clover, 0.08), blurRadius: 14, offset: const Offset(0, 4)),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.6, -1),
            end: Alignment(0.6, 1),
            colors: [Color(0xFFF1F9EC), Color(0xFFDCEFC8)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BackArrow(onTap: () => Nav.backTo(context, AppRoutes.home)),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: AppColors.alpha(AppColors.clover, 0.18), blurRadius: 14, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Svg(AppIcons.clover(), size: 28),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text('오늘의 작은 행운', textAlign: TextAlign.center, style: ts(17, weight: bold)),
                    const SizedBox(height: 28),
                    AppCard(
                      radius: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                      shadow: [
                        BoxShadow(color: AppColors.alpha(AppColors.clover, 0.10), blurRadius: 24, offset: const Offset(0, 8)),
                      ],
                      child: Column(
                        children: [
                          Svg(AppIcons.quote(), size: 22, height: 16),
                          const SizedBox(height: 12),
                          Text(
                            '천천히 걸어도 괜찮아요.\n방향이 맞다면, 속도는 중요하지 않아요.',
                            textAlign: TextAlign.center,
                            style: ts(16, weight: bold, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('나만의 손글씨로 따라 적어보세요',
                        style: ts(13, weight: bold, color: AppColors.cloverDark)),
                    const SizedBox(height: 10),
                    AppCard(
                      padding: const EdgeInsets.all(18),
                      shadow: cloverShadow,
                      child: SizedBox(
                        height: 120,
                        child: Stack(
                          children: [
                            // 공책 줄 배경 (입력칸과 분리해서 그립니다)
                            const Positioned.fill(
                              child: IgnorePointer(child: CustomPaint(painter: _LinedPaperPainter())),
                            ),
                            Positioned.fill(
                              child: TextField(
                                controller: _controller,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLines: null,
                                expands: true,
                                textAlignVertical: TextAlignVertical.top,
                                style: ts(13, height: 28 / 13),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  hintText: '오늘의 한마디를 따라 적어보세요',
                                  hintStyle: ts(13, color: AppColors.textMuted, height: 28 / 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, bottomPad(context, 32)),
              child: PrimaryButton(
                label: '필사 저장하기',
                background: AppColors.clover,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  showMockSnack(context, '필사를 저장했어요');
                  Nav.resetTo(context, AppRoutes.transcripts);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 공책 줄 배경 (repeating-linear-gradient: 28px 간격의 연두색 줄)
class _LinedPaperPainter extends CustomPainter {
  const _LinedPaperPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE9F2E0)
      ..strokeWidth = 1;
    for (double y = 27.5; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
