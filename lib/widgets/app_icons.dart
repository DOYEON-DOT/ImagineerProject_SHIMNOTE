import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 목업에서 쓰인 SVG 아이콘을 그대로 옮긴 모음입니다.
/// 각 함수는 색상을 받아 SVG 문자열을 만들어 줍니다.
class AppIcons {
  AppIcons._();

  static String _hex(Color c) =>
      '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  static String _op(Color c) => ((c.toARGB32() >> 24 & 0xFF) / 255).toStringAsFixed(3);

  /// stroke 색상 + 투명도 속성
  static String _s(Color c) => 'stroke="${_hex(c)}" stroke-opacity="${_op(c)}"';

  /// fill 색상 + 투명도 속성
  static String _f(Color c) => 'fill="${_hex(c)}" fill-opacity="${_op(c)}"';

  static String _wrap(String body, {String viewBox = '0 0 24 24'}) =>
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="$viewBox" fill="none">$body</svg>';

  static String mic(Color c) => _wrap(
      '<rect x="9" y="2" width="6" height="12" rx="3" ${_f(c)}/>'
      '<path d="M5 11a7 7 0 0 0 14 0" ${_s(c)} stroke-width="2" stroke-linecap="round"/>'
      '<line x1="12" y1="19" x2="12" y2="22" ${_s(c)} stroke-width="2" stroke-linecap="round"/>');

  static String back(Color c) => _wrap(
      '<path d="M15 18l-6-6 6-6" ${_s(c)} stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>');

  static String chevronRight(Color c) => _wrap(
      '<path d="M9 6l6 6-6 6" ${_s(c)} stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>');

  static String clover() => _wrap(
      '<path d="M12 12c0-2.5-2-4.5-4.5-4.5S3 9.5 3 12s2 4.5 4.5 4.5S12 14.5 12 12z" fill="#6fae52"/>'
      '<path d="M12 12c0-2.5 2-4.5 4.5-4.5S21 9.5 21 12s-2 4.5-4.5 4.5S12 14.5 12 12z" fill="#6fae52"/>'
      '<path d="M12 12c-2.5 0-4.5-2-4.5-4.5S9.5 3 12 3s4.5 2 4.5 4.5S14.5 12 12 12z" fill="#6fae52"/>'
      '<path d="M12 12c-2.5 0-4.5 2-4.5 4.5S9.5 21 12 21s4.5-2 4.5-4.5S14.5 12 12 12z" fill="#6fae52"/>'
      '<path d="M12 12v8.5" stroke="#4c8a3a" stroke-width="1.6" stroke-linecap="round"/>');

  static String flame() => _wrap(
      '<path d="M12 2c1 4-2 5-2 8a4 4 0 0 0 8 0c0-1-.5-2-1-2 1 3-1 4-2 4a2 2 0 0 1-2-2c0-2 1-3 1-5-2 0-3 1-3-3-1 1-3 3-3 6a5 5 0 0 0 10 0c0-4-3-5-6-6z" fill="#e8a13a"/>');

  static String streakFlame() => _wrap(
      '<path d="M12 2c-2 3-5 5.5-5 10a5 5 0 0 0 10 0c0-1.3-0.4-2.4-1-3.3 0.3 2-0.9 3.1-1.9 3.1a1.9 1.9 0 0 1-1-3.5c0.9-0.8 0.9-2.3-1.1-6.3z" fill="#e8a13a"/>');

  static String home(Color c) => _wrap(
      '<path d="M3 11l9-8 9 8" ${_s(c)} stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>'
      '<path d="M5 10v10h14V10" ${_s(c)} stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>');

  static String calendar(Color c, {double width = 2}) => _wrap(
      '<rect x="3" y="5" width="18" height="16" rx="2" ${_s(c)} stroke-width="$width"/>'
      '<path d="M3 10h18" ${_s(c)} stroke-width="$width"/>');

  static String waves(Color c) => _wrap(
      '<path d="M3 8c2-2 4-2 6 0s4 2 6 0 4-2 6 0" ${_s(c)} stroke-width="2" stroke-linecap="round"/>'
      '<path d="M3 13c2-2 4-2 6 0s4 2 6 0 4-2 6 0" ${_s(c)} stroke-width="2" stroke-linecap="round"/>'
      '<path d="M3 18c2-2 4-2 6 0s4 2 6 0 4-2 6 0" ${_s(c)} stroke-width="2" stroke-linecap="round"/>');

  static String pencil(Color c, {double width = 1.8}) => _wrap(
      '<path d="M4 20l3-1 10-10-2-2L5 17l-1 3z" ${_s(c)} stroke-width="$width" stroke-linejoin="round"/>'
      '<path d="M15 5l2 2" ${_s(c)} stroke-width="$width"/>');

  static String user(Color c) => _wrap(
      '<circle cx="12" cy="8" r="4" ${_s(c)} stroke-width="1.8"/>'
      '<path d="M4 20c1.5-4 5-6 8-6s6.5 2 8 6" ${_s(c)} stroke-width="1.8" stroke-linecap="round"/>');

  static String info(Color c, {double width = 1.6}) => _wrap(
      '<circle cx="12" cy="12" r="9" ${_s(c)} stroke-width="$width"/>'
      '<line x1="12" y1="11" x2="12" y2="16.5" ${_s(c)} stroke-width="$width" stroke-linecap="round"/>'
      '<circle cx="12" cy="7.6" r="1" ${_f(c)}/>');

  static String retry(Color c) => _wrap(
      '<path d="M4 12a8 8 0 0 1 14.9-4M20 12a8 8 0 0 1-14.9 4" ${_s(c)} stroke-width="2" stroke-linecap="round"/>'
      '<path d="M15 4h4v4M9 20H5v-4" ${_s(c)} stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>');

  static String drop(Color c, {double width = 1.8}) => _wrap(
      '<path d="M12 2C12 2 5 10 5 15a7 7 0 0 0 14 0C19 10 12 2 12 2z" ${_s(c)} stroke-width="$width" stroke-linejoin="round"/>');

  static String pulseLine() => _wrap(
      '<path d="M2 13h30l8-10 10 20 8-14 8 8h30l8-10 10 20 8-14 8 8h30" stroke="#5b9c92" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round" fill="none"/>',
      viewBox: '0 0 180 26');

  static String waveLine(Color c) => _wrap(
      '<path d="M2 12c8-14 16 14 24 0s16 14 24 0 16 14 24 0 16 14 24 0 16 14 24 0" ${_s(c)} stroke-width="1.4" fill="none"/>',
      viewBox: '0 0 140 24');

  static String document() => _wrap(
      '<path d="M4 19V6a2 2 0 0 1 2-2h8l6 6v9a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2z" stroke="#c98a2c" stroke-width="1.7" stroke-linejoin="round"/>'
      '<path d="M8 12h8M8 16h5" stroke="#c98a2c" stroke-width="1.5" stroke-linecap="round"/>');

  static String music(Color c) => _wrap(
      '<path d="M9 18V5l11-2v13" ${_s(c)} stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>'
      '<circle cx="6" cy="18" r="3" ${_s(c)} stroke-width="1.8"/>'
      '<circle cx="17" cy="16" r="3" ${_s(c)} stroke-width="1.8"/>');

  static String play(Color c) => _wrap('<path d="M8 5v14l11-7z" ${_f(c)}/>');

  static String pause(Color c) => _wrap(
      '<rect x="6" y="5" width="4" height="14" rx="1" ${_f(c)}/>'
      '<rect x="14" y="5" width="4" height="14" rx="1" ${_f(c)}/>');

  static String gamepad() => _wrap(
      '<path d="M7 7h10a4 4 0 0 1 4 4v3a3 3 0 0 1-5.2 2L14.5 14h-5l-1.3 2A3 3 0 0 1 3 14v-3a4 4 0 0 1 4-4z" stroke="#5b7a8a" stroke-width="1.7" stroke-linejoin="round"/>'
      '<path d="M8 9.5v3M6.5 11h3" stroke="#5b7a8a" stroke-width="1.5" stroke-linecap="round"/>'
      '<circle cx="15.5" cy="10.5" r="0.9" fill="#5b7a8a"/>'
      '<circle cx="17.5" cy="12" r="0.9" fill="#5b7a8a"/>');

  static String clock(Color c) => _wrap(
      '<circle cx="12" cy="12" r="9" ${_s(c)} stroke-width="1.6"/>'
      '<path d="M12 7v5l3.5 2" ${_s(c)} stroke-width="1.6" stroke-linecap="round"/>');

  static String settings(Color c) => _wrap(
      '<circle cx="12" cy="12" r="3" ${_s(c)} stroke-width="1.8"/>'
      '<path d="M19.4 13a7.9 7.9 0 0 0 0-2l2-1.5-2-3.4-2.4.6a8 8 0 0 0-1.7-1L15 3h-4l-.3 2.6a8 8 0 0 0-1.7 1l-2.4-.6-2 3.4L6.6 11a7.9 7.9 0 0 0 0 2l-2 1.5 2 3.4 2.4-.6a8 8 0 0 0 1.7 1L11 21h4l.3-2.6a8 8 0 0 0 1.7-1l2.4.6 2-3.4-2-1.5z" ${_s(c)} stroke-width="1.6" stroke-linejoin="round"/>');

  static String lock(Color c) => _wrap(
      '<rect x="5" y="11" width="14" height="9" rx="2" ${_s(c)} stroke-width="1.8"/>'
      '<path d="M8 11V8a4 4 0 0 1 8 0v3" ${_s(c)} stroke-width="1.8"/>');

  static String quote() => _wrap(
      '<path d="M0 18V9.5C0 4.5 3 1 8 0l1 3c-3 1-4.5 3-4.5 6H8v9H0zm13 0V9.5c0-5 3-8.5 8-9.5l1 3c-3 1-4.5 3-4.5 6H21v9h-8z" fill="#bcd9a4"/>',
      viewBox: '0 0 24 18');

  static String heart() => _wrap(
      '<path d="M12 21s-7-4.35-9.5-8.5C.5 8.5 3 5 6.5 5c2 0 3.5 1.5 5.5 4 2-2.5 3.5-4 5.5-4 3.5 0 6 3.5 4 7.5C19 16.65 12 21 12 21z" fill="#ffffff" fill-opacity="0.55" stroke="#ffffff" stroke-width="1.2"/>'
      '<circle cx="8.5" cy="9" r="1.4" fill="#ffffff" fill-opacity="0.85"/>');

  /// 물고기 (viewBox 0 0 46 30). [smile] 이 true면 기쁨 물고기처럼 입꼬리를 그립니다.
  static String fish(Color body, {bool smile = false}) => _wrap(
      '<path d="M28 15c0-7-8-11-16-11-4 3-6 7-6 11s2 8 6 11c8 0 16-4 16-11z" ${_f(body)}/>'
      '<path d="M28 15l10-8v16l-10-8z" ${_f(body)}/>'
      '<circle cx="10" cy="12" r="1.6" fill="#16302c"/>'
      '${smile ? '<path d="M6 16c1 1.4 2.6 2 4 2" stroke="#c9770f" stroke-width="1.3" stroke-linecap="round" fill="none"/>' : ''}',
      viewBox: '0 0 46 30');

  /// 어항 제목 뒤 구름 장식 (viewBox 0 0 168 56)
  static String cloud() => _wrap(
      '<path d="M20 34c-9 0-16-6-16-14 0-7 6-13 13-14 2-8 10-14 19-14 8 0 15 5 18 11 2-1 4-1 6-1 9 0 16 6 16 15 0 8-7 15-16 15z" fill="#ffffff" fill-opacity="0.65"/>',
      viewBox: '0 0 168 56');
}

/// SVG 문자열을 그려주는 위젯
class Svg extends StatelessWidget {
  const Svg(this.svg, {super.key, required this.size, this.height});

  final String svg;
  final double size;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(svg, width: size, height: height ?? size);
  }
}
