# NAVER Blog Master Skill v3.4

네이버 블로그 글쓰기·운영을 위한 **AI 멀티에이전트 편집국 Skill**입니다.

사용자는 프롬프트를 잘 쓸 필요가 없습니다.
키워드 하나, 큰 주제 하나, 목적 한 줄, 또는 정리되지 않은 설명만 던져도 됩니다.

예:

```text
$naver-blog-master 양산 물금 중국집
```

```text
$naver-blog-master
주제 상관없이 조회수를 최대한 높이고 싶어.
지금 검색수요가 좋은 소재를 찾아서 써줘.
```

```text
$naver-blog-master
핵심은 빨리 주되 정독 가치와 체류를 높이고 싶어.
애드포스트 운영에도 도움이 되는 글을 써줘.
```

```text
$naver-blog-master
글 작성부터 이미지 전체 개별 자동 생성까지 진행해줘.
```

## v3.4 핵심 철학

**좋아 보이는 글이 아니라, 요구사항이 하나도 빠지지 않은 검증된 글을 발행합니다.**

v3.4부터 `Requirement Ledger`와 `Final Control Tower`가 추가되었습니다.
사용자가 요청한 조건과 스킬 필수 규칙을 처음에 장부화하고,
최종 관리자가 마지막에 다시 전부 대조합니다.

하나라도 빠지면 승인하지 않습니다.

```text
작성
↓
독립 검수
↓
승인
↓
FAIL이면 해당 단계로 자동 반려
↓
수정
↓
재검수
↓
PASS할 때만 다음 단계
```

## 링크 원칙

답은 초반에 주되, 외부 링크는 무조건 초반에 두지 않습니다.

- `URGENT` — 오늘 마감·실시간 잔여석 등: 상단 10~25%
- `STANDARD` — 지도·일반 예약·신청·가입: 본문 후반 60~90% 권장
- `FACT-CHECK` — 공식자료·통계·보도자료: 관련 설명 뒤 또는 후반
- `INTERNAL` — 실제 발행한 관련글: 중반 이후 자연스럽게 연결

즉 **답은 초반에, 깊이는 중간에, 행동 링크는 충분히 이해한 뒤 후반에**가 기본입니다.

## v3.4 주요 기능

- 자유 입력 해석
- Requirement Ledger 요구사항 누락 방지
- AUTO FULL MODE에서도 1~6단계 강제 실행
- 각 단계 Reviewer → Approval Gate
- FAIL 시 해당 단계로 자동 반려하는 Hard Approval Loop
- Final Control Tower 최종 승인 관리자
- 네이버 검색수요·시의성·경쟁도 검토
- 현재 상위 콘텐츠 패턴 벤치마킹
- Answer First 구조
- Adaptive Link Timing
- Action Link Auditor
- No-Search-Back Gate
- Retention Architect
- Internal Journey Designer
- Place Identity / Freshness TTL / Source Provenance
- YouTube 공식·전문·현장 영상 검증
- 모바일 퍼스트 편집
- Trusted Visual Pipeline
- Visual Source Scout
- Rights & License Auditor
- 실존 인물/방송 Identity Visual QA
- Image QA Manager
- Auto Image Queue
- Monetization Safety Gate
- Copy Clean
- 발행용 글쓰기 블록 + 이미지팩 + 링크팩 + QA

## 이미지 신뢰 원칙

실존 인물·연예인·방송·스포츠·여행지 이미지는 AI가 임의로 비슷하게 만들지 않습니다.

먼저 실제 시각 자료를 조사하고 다음을 확인합니다.

- 인물이 맞는가
- 프로그램/팀/장소/시즌이 맞는가
- 당시 의상·유니폼·상황이 맞는가
- 사진을 상업적으로 쓸 수 있는가
- 재가공이 허용되는가
- 출처표시가 필요한가

권리 우선순위 예:

1. 사용자 직접 제공 사진
2. 공공누리 0/1유형 등 상업적 이용·변형 허용 자료
3. CC0 / Public Domain
4. CC BY 등 조건을 충족한 상업적 이용·변형 허용 자료
5. 명시적 재사용 허가가 있는 공식 프레스 자료

일반 뉴스 사진, 연예기사 사진, SNS·팬사진은 **공개되어 있다는 이유만으로 사용하지 않습니다.**

## 개별 이미지 자동 생성

사용자가 `이미지 자동 생성까지` 또는 `전체 이미지 개별 생성`을 요청하면 `AUTO IMAGE QUEUE`를 사용합니다.

가능한 실행 환경에서는:

```text
이미지 1 생성
↓
이미지 2 생성
↓
이미지 3 생성
↓
...
```

처럼 **한 장씩 개별 결과로** 순차 생성합니다.
한 장의 콜라주나 통합시트로 합치지 않습니다.

다만 Skill은 독립 실행 프로그램이 아니라 지침이므로,
현재 ChatGPT/Codex/Agent 런타임이 연속 이미지 도구 호출을 허용해야 완전 자동 진행이 가능합니다.
런타임이 이미지 1장마다 사용자 턴을 요구하면 `NEXT_IMAGE_INDEX`를 유지하고,
사용자가 `계속`, `다음`, 또는 숫자만 입력하면 다음 이미지를 바로 생성합니다.

## 기본 실행 흐름

```text
사용자 자유 입력
↓
Requirement Ledger 생성
↓
1단계 주제·트래픽·상위문서 조사 → 검수 → 승인
↓
2단계 키워드·제목·첫 화면 → 검수 → 승인
↓
3단계 팩트·장소·링크·YouTube → 링크 검증 → 승인
↓
4단계 모바일 구조·체류·내부 이동 → 검수 → 승인
↓
5단계 집필·압축·2차 팩트체크 → 승인
↓
6단계 실제 이미지 자료 검색 → 권리 검수 → 인물/장소 사실 검수 → 이미지 설계 → 이미지 관리자 승인
↓
Reader Simulation + Final Gates
↓
Final Control Tower
↓
PASS일 때만 Publish Package
↓
요청 시 Auto Image Queue
```

## 수익화 원칙

애드포스트 광고 클릭을 직접 유도하지 않습니다.
광고를 가리키는 문구·화살표·이미지·클릭 요청도 사용하지 않습니다.

대신 다음을 강화합니다.

- 검색 유입
- 정독 가치
- 스크롤 깊이
- 실제 내부글 이동
- 재방문 가치
- 주제 집중도
- 모바일 가독성
- 신뢰도

즉 **광고 클릭을 조작하는 스킬이 아니라, 신뢰도 높은 콘텐츠 소비 경험을 만들어 정상적인 수익 기회를 높이는 스킬**입니다.

## 설치 후 업데이트

GitHub 저장소의 `SKILL.md`가 최신이어도 로컬 Codex/Agent 스킬은 자동으로 바뀌지 않을 수 있습니다.
최신 저장소를 받은 뒤 설치 스크립트를 다시 실행해 로컬 버전을 갱신하세요.
