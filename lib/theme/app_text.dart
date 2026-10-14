import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// 목업 텍스트 스타일 헬퍼
/// 기본 폰트는 Noto Sans KR (앱 테마에서 지정), 로고 글씨만 Gowun Dodum 입니다.
TextStyle ts(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = AppColors.textDark,
  double? height,
  double? letterSpacing,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: color,
  );
}

const FontWeight bold = FontWeight.w700;

/// 로고 글씨 스타일 (Gowun Dodum)
/// Gowun Dodum에 없는 글자(예: '쉼')가 깨지지 않도록 Noto Sans KR로 대신 그립니다.
TextStyle logoStyle(double size, Color color) {
  final fallback = GoogleFonts.notoSansKr().fontFamily;
  return GoogleFonts.gowunDodum(fontSize: size, color: color).copyWith(
    fontFamilyFallback: [if (fallback != null) fallback],
  );
}
