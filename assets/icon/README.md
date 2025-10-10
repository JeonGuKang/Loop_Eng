# LOOP ENG 커스텀 아이콘 생성 가이드

## 현재 상태
- flutter_launcher_icons 패키지가 설치되어 있음
- 기본 아이콘이 성공적으로 생성됨
- iOS와 Android 모두에 적용됨

## 커스텀 아이콘 생성 방법

### 방법 1: 온라인 도구 사용
1. https://appicon.co/ 또는 https://icon.kitchen/ 방문
2. 제공된 아이콘 이미지를 업로드
3. 다양한 크기로 자동 생성된 아이콘 다운로드
4. assets/icon/app_icon.png 파일 교체

### 방법 2: 이미지 편집 도구 사용
1. Photoshop, GIMP, 또는 Canva 사용
2. 1024x1024 픽셀 크기로 새 이미지 생성
3. 제공된 디자인 요소들을 재현:
   - 배경: 청록색에서 보라색 그라데이션
   - 텍스트: "LOOP ENG" (흰색, 굵은 글씨)
   - 아이콘들: 돋보기, 얼굴, 화살표 등
4. PNG 형식으로 저장

### 방법 3: 프로그래밍 방식 생성
Flutter에서 Canvas를 사용하여 아이콘을 프로그래밍 방식으로 생성할 수도 있습니다.

## 다음 단계
1. 원하는 방법으로 커스텀 아이콘 생성
2. assets/icon/app_icon.png 파일 교체
3. `flutter pub run flutter_launcher_icons:main` 실행
4. `flutter clean && flutter run` 실행

## 주의사항
- iOS: 알파 채널이 있으면 App Store에서 거부될 수 있음 (remove_alpha_ios: true 설정됨)
- Android: 다양한 해상도에 맞는 아이콘이 자동 생성됨
- 권장 크기: 최소 1024x1024 픽셀
