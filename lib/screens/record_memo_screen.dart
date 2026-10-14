import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';

/// 9-2. 오늘의 메모
/// - 뒤로가기 → 9. 기록
/// - 메모 저장하기 → 저장 안내 후 9. 기록으로 돌아갑니다
class RecordMemoScreen extends StatefulWidget {
  const RecordMemoScreen({super.key});

  @override
  State<RecordMemoScreen> createState() => _RecordMemoScreenState();
}

class _RecordMemoScreenState extends State<RecordMemoScreen> {
  final _controller = TextEditingController(
    text: '과제 마감 때문에 지쳤지만, 소리를 듣고 나니 마음이 좀 편안해졌다.',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    FocusScope.of(context).unfocus();
    showMockSnack(context, '메모를 저장했어요');
    Nav.backTo(context, AppRoutes.records);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, topPad(context, 56), 24, bottomPad(context, 32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CenterTitleHeader(
                title: '9월 17일의 메모',
                onBack: () => Nav.backTo(context, AppRoutes.records),
              ),
              const SizedBox(height: 24),
              AppCard(
                radius: 16,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('웰니스 스코어', style: ts(12, color: AppColors.textSub)),
                    Text('72점 · 잔잔한 빗소리', style: ts(14, weight: bold, color: AppColors.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('오늘 하루는 어땠나요?', style: ts(13, weight: bold)),
              const SizedBox(height: 10),
              Expanded(
                child: AppCard(
                  padding: const EdgeInsets.all(18),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: ts(14, height: 1.7),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      hintText: '오늘의 메모',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(label: '메모 저장하기', onTap: _save),
            ],
          ),
        ),
      ),
    );
  }
}
