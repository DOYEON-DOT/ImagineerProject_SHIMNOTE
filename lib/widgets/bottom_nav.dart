import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../navigation/nav.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'app_icons.dart';
import 'common.dart';

enum NavTab { home, records, transcripts, fishTank, none }

/// 하단 탭바 (홈 / 기록 / 어항)
/// 9-3 필사 화면에서는 [showTranscripts] 를 켜서 '필사' 탭이 추가됩니다.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.current, this.showTranscripts = false});

  final NavTab current;
  final bool showTranscripts;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      height: 76 + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, NavTab.home, '홈', AppRoutes.home, AppIcons.home),
          _item(context, NavTab.records, '기록', AppRoutes.records, AppIcons.calendar),
          if (showTranscripts)
            _item(context, NavTab.transcripts, '필사', AppRoutes.transcripts, AppIcons.pencil),
          _item(context, NavTab.fishTank, '어항', AppRoutes.fishTank, AppIcons.waves),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    NavTab tab,
    String label,
    String route,
    String Function(Color) icon,
  ) {
    final active = tab == current;
    final color = active ? AppColors.primary : AppColors.textMuted;
    return Expanded(
      child: Tap(
        onTap: active ? null : () => Nav.resetTo(context, route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Svg(icon(color), size: 22),
            const SizedBox(height: 4),
            Text(label, style: ts(11, weight: active ? bold : FontWeight.w400, color: color)),
          ],
        ),
      ),
    );
  }
}
