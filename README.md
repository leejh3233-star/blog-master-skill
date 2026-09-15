# NAVER Blog Master Skill

네이버 블로그 글쓰기·운영을 위한 독립형 AI Skill 프로젝트입니다.

## 핵심 기능

- PROJECT DNA 자동 생성
- Command 400 기반 필요한 명령 자동 선택
- 최신 트렌드/검색의도/경쟁 콘텐츠 조사
- 검색 + 홈피드 하이브리드 제목/구조
- 1~6단계 글쓰기 워크플로
- 공식자료 우선 팩트체크
- 링크/날짜/숫자 2차 검증
- 실제 발행 글 기반 내부링크
- 중복 없는 개별 이미지 설계
- 성과 피드백 루프

## 설치

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1
```

### macOS / Linux

```bash
chmod +x install.sh
./install.sh
```

기본 설치 위치:

```text
~/.agents/skills/naver-blog-master/SKILL.md
```

## 호출 예시

```text
$naver-blog-master BLOG MASTER — 새 프로젝트
```

```text
$naver-blog-master BLOG MASTER — 새 글 시작
```

이후 같은 작업 흐름에서는:

```text
1단계
2단계
3단계
4단계
5단계
6단계
```

처럼 단계별로 사용할 수 있습니다.

## 권장 사용 방식

이 스킬은 특정 블로그의 문체를 복제하는 도구가 아닙니다.
프로젝트별 PROJECT DNA와 최신 조사 결과를 바탕으로 검색·추천·신뢰·콘텐츠 자산화를 함께 최적화합니다.

## 사장님AI와의 관계

이 저장소는 사장님AI와 독립적으로 유지합니다.
사장님AI에서는 필요할 때 이 스킬을 별도 호출하거나, 향후 모듈 형태로 연결할 수 있습니다.
