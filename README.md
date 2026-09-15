# NAVER Blog Master Skill v3.0

네이버 블로그 글쓰기·운영을 위한 **AI 멀티에이전트 편집국 Skill**입니다.

사용자는 프롬프트를 잘 쓸 필요가 없습니다.
키워드 하나, 큰 주제 하나, 목적 한 줄, 또는 정리되지 않은 설명만 던져도 됩니다.

예:

```text
$naver-blog-master 양산 물금 중국집
```

```text
$naver-blog-master 이번 주말에 아이와 부산 쪽으로 갈 부모들이 도움받을 만한 여행글을 만들고 싶어
```

```text
$naver-blog-master 이번에는 조회수가 목표야. 여행 맛집에서 네이버 검색수요 좋은 소재를 찾아 글을 써줘
```

## v3.0 핵심 변화

- 자유 입력 해석 직원 추가
- AUTO FULL MODE에서도 1~6단계 강제 실행
- 각 단계별 독립 Reviewer + Approval Gate
- 네이버 실제 검색수요 기반 주제 선정
- 모바일 퍼스트 구조와 편집
- Place Identity 검증
- Freshness TTL 재검증
- 네이버 지도·예약·주차·공식페이지·교통 등 Reader Action Links
- YouTube 영상 적극 활용 + 내용·최신성·링크 검증
- Source Provenance Ledger
- Content Completeness 검사
- 5단계 Second Fact Check
- 6단계 Visual Fact Sheet + Rights Gate + Semantic Duplicate QA
- 방송·스포츠·연예·실시간 이슈 이미지 사실/권리 검증
- 검색형/홈피드형/행동직전/모바일 독자 Reader Simulation
- 최종 편집장 승인 후 결과만 출력

## 내부 실행 구조

```text
자유 입력
↓
입력 해석 직원
↓
1단계 주제·트래픽 직원
→ 검증 → 승인
↓
2단계 검색의도·키워드·제목 직원
→ 검증 → 승인
↓
3단계 팩트·장소·링크·YouTube 직원
→ Place Identity / Link / Video / Freshness 검증
→ 승인
↓
4단계 본문 구조·모바일 UX 직원
→ 완결성 검증 → 승인
↓
5단계 전문 집필 직원
→ 모바일 편집 → 2차 팩트·링크 검증 → 승인
↓
6단계 이미지 디렉터
→ Visual Fact / Rights / Duplicate 검증 → 승인
↓
Reader Simulation
↓
Final QA
↓
최종 편집장
↓
사용자에게 발행 가능한 결과만 출력
```

## 모바일 퍼스트

최종 글은 모바일에서 읽기 쉽게 편집합니다.

- 짧은 문단
- 한 문단 한 핵심
- 짧고 명확한 소제목
- 가격·주소·시간·휴무 등 핵심정보를 긴 문장 속에 숨기지 않음
- 큰 표 남용 금지
- 관련 링크는 해당 문단 바로 아래 배치
- 이미지가 긴 글을 자연스럽게 끊도록 설계
- 소제목만 훑어도 글의 흐름을 알 수 있게 구성

## 독자가 다시 검색하지 않게

글 주제에 따라 다음 링크를 자동 검토·검증합니다.

- 네이버 지도
- 공식 홈페이지
- 예약
- 주차
- 메뉴
- 입장권/예매
- 교통
- 정부/기관 신청페이지
- 공식 일정/기록
- YouTube 영상

링크 수를 늘리는 것이 목적이 아니라 **독자가 다음 행동을 바로 할 수 있게 하는 것**이 목적입니다.

## YouTube Video Desk

공식 기관·방송사·구단·관광청을 우선하고, 필요하면 신뢰도 높은 전문 채널과 현장형 크리에이터도 검토합니다.

검증 항목:
- 링크 정상 작동
- 영상 제목과 실제 내용 일치
- 최신성
- 채널 신뢰도
- 해당 문단과 직접 관련성

영상은 글 끝에 몰아넣지 않고 필요한 문단 바로 아래에 배치합니다.

## 실시간 이슈 이미지

방송·스포츠·연예·실시간 이슈는 일반 이미지 생성과 분리합니다.

Visual Fact Sheet → 권리 확인 → 시각 특징 추출 → 이미지 설계 → 사실/권리 검증 순서로 처리합니다.

정확한 인물·유니폼·장소를 확인하기 어렵다면 잘못된 리얼 이미지를 만들지 않고 데이터형/정보형 이미지로 전환합니다.

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

## 호출

```text
$naver-blog-master [생각나는 대로 요청]
```

기본은 AUTO FULL MODE입니다.

특정 단계만 보고 싶으면:

```text
1단계만
3단계만
5단계만
6단계만
검수
내부 보고서
```

## 사장님AI와의 관계

이 저장소는 독립 스킬 프로젝트로 유지합니다.
사장님AI나 다른 프로젝트에서 필요할 때 외부 스킬로 호출할 수 있습니다.
