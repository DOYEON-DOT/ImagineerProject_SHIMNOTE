import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'app_icons.dart';

/// 탭 영역 전체를 누를 수 있게 해 주는 래퍼 (목업의 <a> 링크 역할)
class Tap extends StatelessWidget {
  const Tap({super.key, required this.onTap, required this.child});

  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}

/// 흰색 둥근 카드 (목업 공통 카드 스타일)
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 18,
    this.color = AppColors.white,
    this.shadow,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final List<BoxShadow>? shadow;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow ?? AppColors.cardShadow(),
      ),
      child: child,
    );
  }
}

/// 목업의 '<' 뒤로가기 아이콘
class BackArrow extends StatelessWidget {
  const BackArrow({super.key, required this.onTap, this.color = AppColors.textDark, this.size = 24});

  final VoidCallback onTap;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Svg(AppIcons.back(color), size: size),
    );
  }
}

/// 가운데 제목 + 왼쪽 뒤로가기 헤더 (마이페이지, 오늘의 메모, 사운드 재생)
class CenterTitleHeader extends StatelessWidget {
  const CenterTitleHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.color = AppColors.textDark,
    this.fontSize = 16,
    this.backSize = 24,
  });

  final String title;
  final VoidCallback onBack;
  final Color color;
  final double fontSize;
  final double backSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(title, style: ts(fontSize, weight: bold, color: color)),
          Align(
            alignment: Alignment.centerLeft,
            child: BackArrow(onTap: onBack, color: color, size: backSize),
          ),
        ],
      ),
    );
  }
}

/// 가로 꽉 차는 기본 버튼
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.background = AppColors.primary,
    this.foreground = AppColors.white,
    this.padding = 16,
    this.radius = 16,
    this.fontSize = 15,
    this.icon,
    this.shadow,
  });

  final String label;
  final VoidCallback? onTap;
  final Color background;
  final Color foreground;
  final double padding;
  final double radius;
  final double fontSize;
  final Widget? icon;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: shadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 10)],
            Text(label, style: ts(fontSize, weight: bold, color: foreground)),
          ],
        ),
      ),
    );
  }
}

/// 둥근 정보 안내 박스 (i 아이콘 + 문구)
class InfoBanner extends StatelessWidget {
  const InfoBanner({
    super.key,
    required this.text,
    this.background = AppColors.infoBg,
    this.color = AppColors.textInfo,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.radius = 14,
    this.alignTop = false,
  });

  final String text;
  final Color background;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool alignTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
      child: Row(
        crossAxisAlignment: alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: alignTop ? 2 : 0),
            child: Svg(AppIcons.info(color), size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: ts(12, color: color, height: 1.5))),
        ],
      ),
    );
  }
}

/// 가로 진행 막대
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 10,
    this.radius = 6,
    this.track = AppColors.track,
  });

  final double value; // 0.0 ~ 1.0
  final Color color;
  final double height;
  final double radius;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        color: track,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: value.clamp(0.0, 1.0),
          heightFactor: 1,
          child: Container(
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius)),
          ),
        ),
      ),
    );
  }
}

/// 내용이 짧으면 화면을 꽉 채우고(하단 버튼을 바닥에 붙임),
/// 길면 스크롤되는 영역. 목업의 flex-grow 여백(Spacer) 구현용입니다.
class FillScrollView extends StatelessWidget {
  const FillScrollView({super.key, required this.padding, required this.children});

  final EdgeInsets padding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (constraints.maxHeight - padding.vertical).clamp(0.0, double.infinity),
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 화면 높이가 모자라면 내용 전체를 비율대로 살짝 줄여서 넘치지 않게 합니다.
/// (작은 기기에서 노란·검은 줄무늬 overflow 경고가 뜨는 것을 막아요)
class ShrinkToFit extends StatelessWidget {
  const ShrinkToFit({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(fit: BoxFit.scaleDown, child: child),
    );
  }
}

/// 원형 배경 장식 (목업의 연한 민트 동그라미)
class BubbleDeco extends StatelessWidget {
  const BubbleDeco({super.key, required this.size, this.opacity = 1});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(color: AppColors.bubble, shape: BoxShape.circle),
      ),
    );
  }
}

/// 목업의 상단 여백(390x844 기준, 상태바 포함)을 실제 기기에 맞춰 줍니다.
/// 상태바가 높은 기기(노치)에서는 상태바 아래로 내려가도록 보정합니다.
double topPad(BuildContext context, double mockupTop) {
  final status = MediaQuery.paddingOf(context).top;
  return mockupTop > status + 12 ? mockupTop : status + 12;
}

/// 하단 홈 인디케이터 영역까지 고려한 아래 여백
double bottomPad(BuildContext context, double mockupBottom) =>
    mockupBottom + MediaQuery.paddingOf(context).bottom;

/// 아직 기능이 연결되지 않은 버튼을 눌렀을 때 짧게 안내합니다.
void showMockSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textDark,
        duration: const Duration(milliseconds: 1600),
      ),
    );
}
