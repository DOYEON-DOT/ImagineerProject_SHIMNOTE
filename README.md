# 쉼노트 (ShimNote) – Flutter UI

목소리로 오늘의 감정을 기록하고, 웰니스 스코어와 힐링 사운드를 추천받는 앱의 UI입니다.
"쉼노트 UI 목업"의 16개 화면과 화면 간 이동을 Flutter로 옮겼습니다.

## 실행 방법 (VS Code)

1. 압축을 풀고 VS Code에서 `shimnote` 폴더를 엽니다.
2. 터미널에서 플랫폼 폴더(android, ios 등)를 만들어 줍니다. 기존 `lib/` 코드는 덮어쓰지 않습니다.
   ```bash
   flutter create .
   ```
3. 패키지를 받고 실행합니다.
   ```bash
   flutter pub get
   flutter run
   ```

- Flutter 3.27 이상이 필요합니다.
- 폰트(Noto Sans KR, Gowun Dodum)는 `google_fonts` 패키지가 처음 실행 때 인터넷에서 받아옵니다.
  에뮬레이터/기기가 인터넷에 연결되어 있어야 해요.

## 폴더 구조

```
lib/
├── main.dart                     앱 시작, 테마, 라우터 설정
├── navigation/
│   ├── app_routes.dart           16개 화면 라우트 이름과 연결
│   └── nav.dart                  화면 이동 헬퍼 (push / replace / 탭 이동 / 뒤로가기)
├── theme/
│   ├── app_colors.dart           목업 색상
│   └── app_text.dart             텍스트 스타일 헬퍼
├── widgets/
│   ├── app_icons.dart            목업 SVG 아이콘
│   ├── common.dart               카드, 버튼, 헤더, 안내 박스 등 공통 위젯
│   ├── bottom_nav.dart           하단 탭바 (홈 / 기록 / (필사) / 어항)
│   ├── animations.dart           퍼지는 원, 통통 튀는 애니메이션
│   ├── record_widgets.dart       달력, 필사 목록
│   └── fish_widgets.dart         어항 배경, 헤더, 물고기 레벨 카드
└── screens/                      16개 화면
assets/images/logo.png            스플래시 로고
```

## 화면 목록과 연결

| 번호 | 화면 | 파일 | 이동 |
|---|---|---|---|
| 1 | 스플래시 | `splash_screen.dart` | 2초 후(또는 탭) → 온보딩 |
| 2 | 온보딩 | `onboarding_screen.dart` | 게스트로 시작하기 → 홈 |
| 3 | 메인(홈) | `home_screen.dart` | 하루 기록하기 → 감정 담기 / 작은 행운 → 3-1 / 탭: 기록, 어항 |
| 3-1 | 작은 행운 | `lucky_screen.dart` | ← 홈 / 필사 저장하기 → 기록(필사 탭) |
| 4 | 감정 담기 | `recording_screen.dart` | ← 홈 / 녹음 완료 → 분석 (대기·녹음 중·오류 상태 포함) |
| 5 | 분석 | `analyzing_screen.dart` | 3초 후(또는 탭) → 웰니스 스코어 |
| 6 | 웰니스 스코어 | `wellness_score_screen.dart` | ← 감정 담기 / 추천 사운드 듣기 → 사운드 추천 |
| 7 | 사운드 추천 | `sound_recommend_screen.dart` | ← 웰니스 스코어 / 사운드 카드 → 사운드 재생 / 탭: 홈, 기록, 어항 |
| 8 | 사운드 재생 | `sound_play_screen.dart` | ← 사운드 추천 / 재생·일시정지 / 힐링 종료 → 홈 |
| 9 | 기록 | `records_screen.dart` | 캘린더·필사 탭 / 오늘의 메모 → 9-2 / 첫 사용자 화면 보기 → 9-1 / 탭: 홈, 어항 |
| 9-1 | 기록(첫 사용자) | `records_empty_screen.dart` | 기록 있는 화면 보기 → 9 / 감정 담으러 가기 → 홈 |
| 9-2 | 오늘의 메모 | `record_memo_screen.dart` | ← 기록 / 메모 저장하기 → 기록 |
| 9-3 | 필사 | `records_screen.dart` (기록 화면의 필사 탭) | 팀 결정으로 별도 화면 대신 기록 탭 안에 표시. `transcripts_screen.dart`는 쓰지 않아 지워도 돼요 |
| 10 | 어항 | `fish_tank_screen.dart` | 물고기 탭 반응, 잠긴 물고기 안내 / 첫 사용자 화면 보기 → 10-1 / 설정 → 마이페이지 / 탭: 홈, 기록 |
| 10-1 | 어항(첫 사용자) | `fish_tank_empty_screen.dart` | 성장한 화면 보기 → 10 / 설정 → 마이페이지 |
| 11 | 마이페이지 | `my_page_screen.dart` | ← 어항 / 데이터 초기화 안내 열기·닫기 |

### 화면 이동 방식

- **앞으로 가기**는 `Nav.push` 로 화면을 쌓습니다. (기기의 뒤로가기 버튼도 동작해요)
- **하단 탭**은 `Nav.resetTo` 로 스택을 비우고 해당 탭 화면에서 다시 시작합니다.
- **화면 안의 `<` 버튼**은 `Nav.backTo` 로 목업에 지정된 화면으로 돌아갑니다.
- 분석 화면은 결과 화면으로 넘어가면 스택에서 빠집니다(`Nav.replace`).

## 아직 목업 수준인 부분

실제 녹음, 감정 분석 API, 사운드 재생, 데이터 저장은 연결되어 있지 않고 목업의 예시 데이터를 보여 줍니다.
기능을 붙일 때는 각 화면의 예시 값(점수 72, 날짜 9월 17일 등)을 상태 관리나 API 결과로 바꾸면 됩니다.
