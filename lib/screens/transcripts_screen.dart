import 'package:flutter/material.dart';

import '../theme/app_text.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/common.dart';
import '../widgets/record_widgets.dart';

/// 9-3. 필사
/// 3-1. 작은 행운에서 '필사 저장하기'를 누르면 이 화면으로 옵니다.
/// 하단 탭에 '필사' 탭이 추가된 버전입니다. (홈 / 기록 / 필사 / 어항)
class TranscriptsScreen extends StatelessWidget {
  const TranscriptsScreen({super.key});

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
                  Text('나의 필사', style: ts(17, weight: bold)),
                  const SizedBox(height: 20),
                  const TranscriptList(),
                ],
              ),
            ),
          ),
          const AppBottomNav(current: NavTab.transcripts, showTranscripts: true),
        ],
      ),
    );
  }
}
