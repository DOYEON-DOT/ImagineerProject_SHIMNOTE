import 'package:flutter/material.dart';

/// 현재 네비게이션 스택에 쌓인 화면 이름을 기억합니다.
/// 뒤로가기 버튼이 목업에 지정된 화면으로 정확히 돌아가도록 하는 데 씁니다.
class RouteStackObserver extends NavigatorObserver {
  final List<Route<dynamic>> _routes = [];

  /// 아래에서 위 순서의 화면 이름 목록
  List<String?> get stack => _routes.map((r) => r.settings.name).toList();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routes.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routes.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routes.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final i = oldRoute == null ? -1 : _routes.indexOf(oldRoute);
    if (newRoute == null) {
      if (i >= 0) _routes.removeAt(i);
    } else if (i >= 0) {
      _routes[i] = newRoute;
    } else {
      _routes.add(newRoute);
    }
  }
}

final RouteStackObserver routeObserver = RouteStackObserver();

/// 화면 이동 헬퍼
class Nav {
  Nav._();

  /// 새 화면을 위에 쌓습니다. (예: 홈 → 감정 담기)
  static Future<T?> push<T>(BuildContext context, String route) =>
      Navigator.of(context).pushNamed<T>(route);

  /// 현재 화면을 새 화면으로 바꿉니다. (예: 분석 → 웰니스 스코어)
  static void replace(BuildContext context, String route) =>
      Navigator.of(context).pushReplacementNamed(route);

  /// 스택을 비우고 해당 화면부터 다시 시작합니다. (하단 탭 이동, 온보딩 완료 등)
  static void resetTo(BuildContext context, String route) =>
      Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);

  /// 목업의 뒤로가기(<) 버튼: [route] 화면으로 돌아갑니다.
  /// 스택에 해당 화면이 있으면 그 화면까지 pop, 없으면 해당 화면으로 교체합니다.
  static void backTo(BuildContext context, String route) {
    final navigator = Navigator.of(context);
    final stack = routeObserver.stack;
    final idx = stack.lastIndexOf(route);
    if (idx >= 0 && idx < stack.length - 1) {
      navigator.popUntil(ModalRoute.withName(route));
    } else {
      navigator.pushReplacementNamed(route);
    }
  }
}
