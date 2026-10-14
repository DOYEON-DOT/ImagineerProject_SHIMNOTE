import 'package:flutter/material.dart';

/// 쉼노트 목업에서 사용한 색상 모음
class AppColors {
  AppColors._();

  // 배경
  static const Color background = Color(0xFFE4FBF5);
  static const Color bubble = Color(0xFFD3F3EA);
  static const Color mint100 = Color(0xFFCDF1E6);
  static const Color mint200 = Color(0xFFA9E6D4);
  static const Color mint300 = Color(0xFF9FE0CB);
  static const Color white = Color(0xFFFFFFFF);

  // 브랜드
  static const Color primary = Color(0xFF2F9E8F);
  static const Color primaryDark = Color(0xFF237F70);
  static const Color accent = Color(0xFF4A978A);
  static const Color mintBar = Color(0xFF7DD8C5);

  // 텍스트
  static const Color textDark = Color(0xFF16302C);
  static const Color textBody = Color(0xFF2C4A45);
  static const Color textSub = Color(0xFF6B8F89);
  static const Color textSub2 = Color(0xFF5B7D78);
  static const Color textMuted = Color(0xFF9DB8B3);
  static const Color textFaint = Color(0xFF9BC3BC);
  static const Color textInfo = Color(0xFF4A6A64);
  static const Color weekday = Color(0xFF5F8480);
  static const Color dayOff = Color(0xFFC9D9D6);

  // 선 / 트랙
  static const Color divider = Color(0xFFDDF1EC);
  static const Color track = Color(0xFFEEF7F4);
  static const Color infoBg = Color(0xFFEAF2F0);

  // 포인트 컬러
  static const Color coral = Color(0xFFF0A897);
  static const Color orange = Color(0xFFF0B25E);
  static const Color fishJoy = Color(0xFFFFB347);
  static const Color fishCalm = Color(0xFF6FC3E0);
  static const Color clover = Color(0xFF6FAE52);
  static const Color cloverDark = Color(0xFF4C8A3A);
  static const Color fire = Color(0xFFE8A13A);
  static const Color danger = Color(0xFFC96A5A);
  static const Color locked = Color(0xFFB7C6C3);
  static const Color lockedBorder = Color(0xFFC3D2CF);

  /// CSS의 rgba(r,g,b,opacity)처럼 투명도를 적용합니다.
  static Color alpha(Color c, double opacity) => c.withAlpha((opacity * 255).round());

  /// 목업 카드 그림자: 0 4px 14px rgba(47,158,143,0.08)
  static List<BoxShadow> cardShadow([double opacity = 0.08, double blur = 14, double y = 4]) => [
        BoxShadow(
          color: alpha(primary, opacity),
          blurRadius: blur,
          offset: Offset(0, y),
        ),
      ];
}
