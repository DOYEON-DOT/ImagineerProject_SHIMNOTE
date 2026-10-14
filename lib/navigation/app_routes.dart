import 'package:flutter/material.dart';

import '../screens/analyzing_screen.dart';
import '../screens/fish_tank_empty_screen.dart';
import '../screens/fish_tank_screen.dart';
import '../screens/home_screen.dart';
import '../screens/lucky_screen.dart';
import '../screens/my_page_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/record_memo_screen.dart';
import '../screens/recording_screen.dart';
import '../screens/records_empty_screen.dart';
import '../screens/records_screen.dart';
import '../screens/sound_play_screen.dart';
import '../screens/sound_recommend_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/wellness_score_screen.dart';

/// 16개 화면의 라우트 이름 (목업 번호 기준)
class AppRoutes {
  AppRoutes._();

  static const String splash = '/'; //              1. 스플래시
  static const String onboarding = '/onboarding'; // 2. 온보딩
  static const String home = '/home'; //            3. 메인(홈)
  static const String lucky = '/lucky'; //          3-1. 작은 행운
  static const String recording = '/recording'; //  4. 감정 담기
  static const String analyzing = '/analyzing'; //  5. 분석
  static const String wellness = '/wellness'; //    6. 웰니스 스코어
  static const String soundRecommend = '/sound-recommend'; // 7. 사운드 추천
  static const String soundPlay = '/sound-play'; // 8. 사운드 재생
  static const String records = '/records'; //      9. 기록
  static const String recordsEmpty = '/records-empty'; // 9-1. 기록(첫 사용자)
  static const String recordMemo = '/record-memo'; // 9-2. 오늘의 메모
  static const String transcripts = '/transcripts'; // 9-3. 필사 → 기록 화면의 '필사' 탭
  static const String fishTank = '/fish-tank'; //   10. 어항
  static const String fishTankEmpty = '/fish-tank-empty'; // 10-1. 어항(첫 사용자)
  static const String myPage = '/my-page'; //       11. 마이페이지

  static final Map<String, WidgetBuilder> builders = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    home: (_) => const HomeScreen(),
    lucky: (_) => const LuckyScreen(),
    recording: (_) => const RecordingScreen(),
    analyzing: (_) => const AnalyzingScreen(),
    wellness: (_) => const WellnessScoreScreen(),
    soundRecommend: (_) => const SoundRecommendScreen(),
    soundPlay: (_) => const SoundPlayScreen(),
    records: (_) => const RecordsScreen(),
    recordsEmpty: (_) => const RecordsEmptyScreen(),
    recordMemo: (_) => const RecordMemoScreen(),
    // 팀 결정: 필사는 별도 화면이 아니라 기록 탭 안의 '필사' 탭으로 보여 줍니다.
    transcripts: (_) => const RecordsScreen(showTranscripts: true),
    fishTank: (_) => const FishTankScreen(),
    fishTankEmpty: (_) => const FishTankEmptyScreen(),
    myPage: (_) => const MyPageScreen(),
  };

  /// 모든 화면 전환에 부드러운 페이드 효과를 적용합니다.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = builders[settings.name];
    if (builder == null) return null;
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
