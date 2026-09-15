# NAVER Blog Master Skill v3.3

네이버 블로그 글쓰기·운영을 위한 **AI 멀티에이전트 편집국 Skill**입니다.

사용자는 프롬프트를 잘 쓸 필요가 없습니다.
키워드 하나, 큰 주제 하나, 목적 한 줄, 또는 정리되지 않은 설명만 던져도 됩니다.

예:

```text
$naver-blog-master 양산 물금 중국집
```

```text
$naver-blog-master
주말에 6살 아이와 갈 만한 곳을 찾는 부모들이
도움받을 수 있는 여행글을 하나 써줘.
맛집도 같이 연결됐으면 좋겠어.
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

## v3.3 핵심 철학

**답을 빨리 주는 것과 체류시간을 늘리는 것은 서로 반대가 아닙니다.**

독자가 첫 화면에서 핵심을 이해한 뒤,
비교·예외·체크리스트·영상·FAQ·실수 방지·관련글 등
새로운 가치 때문에 자연스럽게 더 읽도록 설계합니다.

링크도 무조건 앞이나 뒤에 고정하지 않습니다.

- 긴급 예매/신청/잔여석 → 상단 10~20%에 빠르게
- 일반 지도/예약/신청 → 핵심정보를 이해한 뒤 20~40%
- 보조 공식자료/영상 → 중후반 50~80%
- 실제 내부글 → 중반 이후 다음 질문과 연결

핵심 원칙:

> 답은 먼저 준다.
> 링크는 적절한 시점에 둔다.
> 체류는 반복이 아니라 추가 가치로 만든다.
> 독자를 다시 검색창으로 보내지 않는다.
> 광고 클릭은 절대 유도하지 않는다.

## v3.3 주요 기능

- 자유 입력 해석
- AUTO FULL MODE에서도 1~6단계 강제 실행
- 네이버 검색수요·시의성·경쟁도 검토
- 현재 상위 콘텐츠 패턴 벤치마킹
- Answer First 구조
- FIRST SCREEN GATE
- Adaptive Link Timing
- LINK TIMING STRATEGIST / GATE
- Mandatory Link Matrix
- ACTION LINK AUDITOR
- No-Search-Back Gate
- Retention Architect
- Retention Value Score
- Internal Journey Designer
- Place Identity / Freshness TTL / Source Provenance
- YouTube 공식·전문·현장 영상 검증
- 모바일 퍼스트 편집
- Visual Fact Sheet / Rights Gate / 이미지 중복 검수
- Reader Simulation
- Monetization Safety Gate
- Copy Clean
- 최종 발행용 글쓰기 블록
- 이미지 제작팩 + 링크팩 + QA 패키지

## 기본 실행 흐름

```text
사용자 자유 입력
↓
0단계 의도 해석
↓
1단계 주제·트래픽·상위문서 조사
↓
2단계 키워드·제목·첫 화면
↓
3단계 팩트·장소·링크·YouTube 검증
↓
링크 긴급도/이탈 위험 분석
↓
4단계 모바일 구조·Retention 설계
↓
실제 내부글 이동 설계
↓
5단계 집필·압축·2차 팩트체크
↓
6단계 이미지 사실·권리·중복 검수
↓
Reader Simulation
↓
First Screen / Link Timing / Retention / Task Completion / Monetization Safety Gate
↓
최종 편집장
↓
발행용 글쓰기 블록 + 이미지팩 + 링크팩 + QA
```

## 최종 출력

### ① 최종 선정 결과
주제 / 제목 / 메인 키워드 / 콘텐츠 각도

### ② 발행용 글쓰기 블록
제목부터 태그까지 복사해 바로 사용할 수 있는 최종 원고입니다.
검증된 독자용 링크와 이미지 삽입 위치도 본문 안에 포함합니다.

### ③ 이미지 제작팩
번호 / 삽입 위치 / 역할 / 텍스트 / 생성 프롬프트

### ④ 검증된 링크팩
링크 목적 / URL / 본문 배치 위치 / 등급

등급:
- URGENT
- STANDARD
- OPTIONAL
- INTERNAL

### ⑤ 최종 QA
PASS 또는 주의사항만 간단하게 보여줍니다.

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

즉 **광고 클릭을 조작하는 스킬이 아니라, 좋은 콘텐츠 소비 경험을 만들어 정상적인 수익 기회를 높이는 스킬**입니다.

## 설치 후 업데이트

GitHub 저장소의 `SKILL.md`가 최신이어도 로컬 Codex/Agent 스킬은 자동으로 바뀌지 않을 수 있습니다.
최신 저장소를 받은 뒤 설치 스크립트를 다시 실행해 로컬 버전을 갱신하세요.
