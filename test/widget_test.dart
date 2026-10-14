import 'package:flutter_test/flutter_test.dart';
import 'package:shimnote/navigation/app_routes.dart';

void main() {
  test('목업의 16개 화면이 모두 라우트에 등록되어 있어요', () {
    expect(AppRoutes.builders.length, 16);
    expect(AppRoutes.builders.keys.toSet().length, 16);
  });
}
