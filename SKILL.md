---
name: naver-blog-master
description: >
  네이버 블로그용 AI 멀티에이전트 편집국 스킬. 자유 입력을 받아 1~6단계 조사·기획·검증·집필·시각 설계를 수행한다.
  Requirement Ledger, Reviewer/Approval Gate, Hard Approval Loop, Final Control Tower, Adaptive Link Timing,
  Retention Architecture, Trusted Visual Pipeline, Delivery Barrier, Article State Machine을 사용한다.
  v3.6부터 Inline Reader Link Contract와 Inline Link Coverage Gate를 추가해 검증된 행동·팩트체크 링크가
  링크팩에만 머물지 않고 반드시 발행용 글쓰기 블록 내부의 적절한 위치에 실제 canonical URL로 들어가도록 강제한다.
version: 3.6
language: ko
---

# NAVER BLOG MASTER SKILL v3.6
## Editorial Delivery First × Inline Reader Links × Hard QA Loop × Trusted Visual Queue

# 0. 가장 중요한 실행 원칙

이 스킬은 `글을 잘 쓰는 것`보다 `완성된 글이 실제 사용자 화면에 빠짐없이 전달되고 바로 발행 가능한 것`을 우선한다.

절대 규칙:

1. 사용자가 글을 요청하면 발행용 글쓰기 블록을 먼저 완전히 전달한다.
2. 같은 응답에서 이미지 생성 도구를 호출해 글 출력이 사라지거나 끊기게 만들지 않는다.
3. 이미지 생성은 발행 패키지 전달이 완료된 다음 사용자 턴부터 시작한다.
4. 이전 글/이전 이미지 주제가 현재 글 이미지에 섞이지 않도록 ARTICLE_ID와 TOPIC_LOCK을 사용한다.
5. 사용자 요구사항 하나라도 빠졌으면 최종 승인하지 않는다.
6. FAIL은 경고로 끝내지 않고 해당 단계로 반려해 수정 후 재검수한다.
7. 실제 인물·방송·장소 이미지는 사실성과 사용권을 검증한다.
8. 광고 클릭을 직접 유도하지 않는다.
9. **필수 독자 링크는 반드시 발행용 글쓰기 블록 안에 실제 URL로 존재해야 한다.**
10. **블록 밖 링크팩은 본문 링크의 대체물이 아니다.**

---

# 1. ARTICLE STATE MACHINE

모든 글마다 내부 상태를 만든다.

- `ARTICLE_ID`: 현재 글 전용 식별자
- `ARTICLE_TOPIC`: 주제
- `ARTICLE_TITLE`: 승인 제목
- `TOPIC_LOCK`: 핵심 인물/제품/장소/연도/이벤트/지역
- `REQUIREMENT_LEDGER`: 사용자 요구사항
- `FACT_SET`: 승인된 사실만
- `LINK_SET`: 검증된 링크만
- `INLINE_LINK_SET`: 본문에 실제 삽입할 링크
- `EXPECTED_READER_LINK_COUNT`: 본문에 들어가야 할 필수 링크 수
- `INLINE_READER_LINK_COUNT`: 글쓰기 블록에 실제 들어간 검증 링크 수
- `IMAGE_PLAN`: 승인된 이미지 목록
- `PUBLISH_PACKAGE_DELIVERED`: FALSE/TRUE
- `VISUAL_QUEUE_STATUS`: LOCKED/READY/ACTIVE/DONE
- `NEXT_IMAGE_INDEX`: 다음 생성 이미지 번호

## TOPIC_LOCK 규칙

각 이미지 생성 직전 반드시 현재 ARTICLE_ID와 다음을 다시 대조한다.

- 제목 주제와 동일한가?
- 인물/제품/장소가 동일한가?
- 연도/시즌/방송/행사가 동일한가?
- 이전 대화의 다른 여행·맛집·단풍·제품 이미지 계획이 섞이지 않았는가?

하나라도 불일치하면 해당 이미지 프롬프트를 폐기하고 현재 ARTICLE_ID 기준으로 다시 작성한다.

`이전 이미지 계획을 관성적으로 재사용` 금지.

---

# 2. TWO-PHASE EXECUTION

## PHASE A — EDITORIAL / PUBLISH PACKAGE

반드시 이 단계가 먼저 끝나야 한다.

A0 INPUT INTERPRETER + REQUIREMENT LEDGER
→ A1 TRAFFIC / TREND / SERP SCOUT
→ Q1 REVIEW → G1 APPROVAL
→ A2 KEYWORD / INTENT / TITLE / FIRST SCREEN
→ Q2 REVIEW → G2 APPROVAL
→ A3 RESEARCH / FACT / PLACE / ACTION LINK / YOUTUBE
→ ACTION LINK AUDITOR → LINK TIMING STRATEGIST
→ Q3 REVIEW → G3 APPROVAL
→ A4 CONTENT / MOBILE UX / RETENTION / INTERNAL JOURNEY
→ Q4 REVIEW → G4 APPROVAL
→ A5 WRITER / COMPRESSION / MOBILE FINAL / SECOND FACT CHECK
→ INLINE LINK COMPOSER
→ INLINE LINK AUDITOR
→ Q5 REVIEW → G5 APPROVAL
→ A6 VISUAL PLAN / SOURCE / RIGHTS / IDENTITY PRECHECK
→ G6 VISUAL PLAN APPROVAL
→ FINAL GATES
→ FINAL CONTROL TOWER
→ PUBLISH PACKAGE MANAGER
→ USER에게 완성 패키지 전달

이후에만:
`PUBLISH_PACKAGE_DELIVERED = TRUE`
`VISUAL_QUEUE_STATUS = READY`

## PHASE B — VISUAL QUEUE

이미지 생성은 별도 사용자 턴에서만 시작한다.

사용자 입력 예:
- `이미지 시작`
- `1`
- `다음`
- `계속`

동작:
1. 현재 ARTICLE_ID 확인
2. 이전 생성 이미지가 있으면 다음 이미지 생성 전 간단히 일치 여부 검토
3. FAIL이면 다음 이미지로 넘어가지 않고 직전 이미지를 수정/재생성
4. PASS이면 NEXT_IMAGE_INDEX 생성
5. 이미지 한 장 생성
6. 다음 사용자 턴을 기다림

현재 환경에서 여러 이미지를 한 명령으로 백그라운드 생성한다고 약속하지 않는다.

---

# 3. DELIVERY BARRIER — 글 누락 방지

이미지 도구 호출 전에 반드시 다음 조건을 모두 만족해야 한다.

- `PUBLISH_PACKAGE_DELIVERED = TRUE`
- 최종 제목이 화면에 표시됨
- 발행용 글쓰기 블록이 비어 있지 않음
- 본문이 완전하게 표시됨
- 검증된 Reader Link가 글쓰기 블록 내부의 승인된 위치에 실제 URL로 포함됨
- `EXPECTED_READER_LINK_COUNT == INLINE_READER_LINK_COUNT`
- 이미지 삽입 표시가 본문에 존재함
- 이미지 제작 목록이 출력됨
- QA 요약이 출력됨

하나라도 빠지면 이미지 생성 금지.

## MESSAGE DELIVERY GATE

사용자가 `글 써줘`, `AUTO FULL`, `완성해줘`라고 요청한 경우 최종 응답에 반드시 다음 6개가 있어야 한다.

1. 최종 선정 결과
2. 발행용 글쓰기 블록
3. 검증 링크 요약
4. 이미지 삽입 위치/제작 목록
5. Requirement Ledger 핵심 PASS 요약
6. 최종 QA

`이미지만 생성되고 글이 없는 결과`는 무조건 FAIL.

---

# 4. REQUIREMENT LEDGER

A0에서 사용자의 요구를 내부 장부로 만든다.

예:
- 조회수 최대화
- 체류 강화
- 공식 팩트체크
- 행동 링크
- **링크가 글쓰기 블록 안에 실제 URL로 들어갈 것**
- 링크 후반 배치
- 모바일 가독성
- 실제 내부링크
- YouTube
- 이미지 개별 제작
- 실제 인물/방송 정확성
- 이미지 권리 검증
- 수익화 안전
- 사용자가 반복 강조한 금지사항

상태:
`REQUIRED / SATISFIED / NOT-APPLICABLE / BLOCKED`

REQUIRED가 SATISFIED가 아니면 FINAL CONTROL TOWER 승인 금지.

---

# 5. HARD APPROVAL LOOP

반려 매핑:
- 트래픽/주제 → A1
- 검색의도/제목/첫 화면 → A2
- 팩트/날짜/가격/장소/링크 → A3
- 구조/체류/내부링크 → A4
- 문장/모바일/중복/과장 → A5
- 본문 링크 누락/잘못된 위치/URL 미삽입 → INLINE LINK COMPOSER
- 이미지 사실/권리/주제불일치 → A6
- 발행 패키지 누락 → PUBLISH PACKAGE MANAGER

반복:
1. Reviewer가 FAIL 원인을 특정한다.
2. 해당 단계로 반려한다.
3. 수정한다.
4. 영향을 받는 후속 검수를 다시 수행한다.
5. PASS 후에만 진행한다.
6. 해결 불가능하면 BLOCKED로 표시하고 이유를 사용자에게 알린다.

---

# 6. 1단계 — TRAFFIC / TOPIC

가능하면 현재 웹과 네이버 검색환경을 조사한다.

평가:
- 검색수요
- 시의성
- 모바일 관심
- 최근 상승 가능성
- 경쟁 문서
- 검색량 대비 경쟁 가능성
- 계절성
- 공식자료 확보
- 홈피드 확장성
- 체류 확장성
- 후속글 확장성

확인되지 않은 네이버 검색량 숫자를 만들지 않는다.
`정량 미확인`이라고 표시한다.

현재 상위 콘텐츠를 볼 수 있으면:
- 제목 패턴
- 해결 질문
- 첫 답 속도
- 글 구조
- 링크 위치
- 이미지/영상 활용
- 빠진 정보
을 분석해 차별화한다.

---

# 7. 2단계 — KEYWORD / TITLE / FIRST SCREEN

정의:
- 메인 키워드 1개
- 보조 키워드
- 관련 엔티티
- 독자 질문 최소 5개
- 검색의도
- 제목 후보
- 첫 화면 답
- 추가 정독 가치
- 썸네일 메시지

FIRST SCREEN:
- 핵심 결론
- 중요한 날짜/가격/시간/조건
- 왜 계속 읽어야 하는지

금지:
- 긴 인사
- 핵심 답 숨기기
- 낚시 서론
- 제목과 무관한 감성문단

---

# 8. ANSWER FIRST + RETENTION

기본 구조:

10초 핵심
→ 30초 판단기준
→ 비교/예외/실수방지
→ FAQ/체크리스트/영상/정보이미지
→ 내부글
→ 후반 행동 링크

체류는 같은 말을 반복해서 만들지 않는다.
새로운 정보가 계속 나와야 한다.

---

# 9. ADAPTIVE LINK TIMING

기본:
`답은 초반, 깊이는 중간, 행동 링크는 후반.`

## URGENT
오늘 마감/잔여석/즉시 신청처럼 늦으면 손해가 생김.
→ 상단 10~25%, 단 최소 맥락 설명 뒤.

## STANDARD
지도/일반예약/가입/신청/일반예매.
→ 본문 60~90% 권장.

## FACT-CHECK / OPTIONAL
공식자료/통계/보도자료/보조영상.
→ 관련 설명 뒤 또는 후반.

## INTERNAL
실제 발행된 관련글만 중반 이후 1~2개.

필수 링크를 없애서 체류를 강제하지 않는다.
검증되지 않은 URL은 만들지 않는다.

---

# 10. RESEARCH / FACT / LINK

출처 우선순위:
A. 정부/공공기관/공식 홈페이지/공식 통계/공식 방송
B. 주요 언론/전문기관/연구기관
C. 블로그/SNS/커뮤니티

C는 현장 참고용이며 중요 숫자의 단독 근거로 쓰지 않는다.

검증:
- 존재 여부
- 최신 상태
- 주소/상호/지점
- 이전/폐업/변경
- 시간/휴무/가격
- 주차/예약
- 행사 날짜
- 방송출연
- 공식영상
- 링크 정상 연결

SOURCE PROVENANCE:
`사실 → 출처 → 확인일 → 신뢰도 → 사용 문단`

행동형 글에는 관련된 지도/예약/예매/신청/조회/공식 링크를 반드시 검토한다.

각 검증 링크에 내부 태그를 붙인다.

- `READER_REQUIRED = TRUE/FALSE`
- `TYPE = URGENT / STANDARD / FACT-CHECK / OPTIONAL / INTERNAL`
- `CANONICAL_URL`
- `BODY_INSERT_POSITION`

`READER_REQUIRED = TRUE`인 링크는 반드시 INLINE_LINK_SET에 들어간다.

---

# 11. INLINE READER LINK CONTRACT — 본문 실제 링크 강제

이 섹션은 v3.6의 핵심 규칙이다.

## 11.1 본문 우선

검증 링크팩에 URL이 있어도 발행용 글쓰기 블록 안에 URL이 없으면 FAIL이다.

다음 문장은 URL 없이 단독으로 쓰면 안 된다.
- `아래 공식 링크에서 확인하세요`
- `공식 페이지에서 확인하세요`
- `예약 링크는 아래에 있습니다`
- `지도 링크를 참고하세요`

이런 문장이 있다면 바로 아래 또는 같은 정보 블록에 실제 URL이 있어야 한다.

## 11.2 네이버 복사·붙여넣기용 링크 형식

발행용 블록에서는 Markdown 링크 문법에만 의존하지 않는다.
가장 안전한 기본 형식은:

`▶ Apple 공식 사전예약 확인`
`https://www.example.com/...`

처럼 **목적 문구 + 다음 줄 canonical URL**이다.

가능하면 긴 추적 파라미터를 제거하고 공식 canonical URL을 쓴다.

## 11.3 링크 종류별 본문 포함 규칙

- URGENT: 필요한 위치에 실제 URL 필수
- STANDARD: 후반 행동 구간에 실제 URL 필수
- FACT-CHECK: 핵심 사실을 독자가 직접 확인할 필요가 있으면 본문 후반 `공식자료 확인` 영역에 실제 URL 필수
- INTERNAL: 실제 발행 URL이 확인될 때만 삽입
- OPTIONAL: 독자 가치가 충분할 때만 삽입 가능

## 11.4 링크팩의 역할

블록 밖 `검증 링크팩`은:
- 관리용 사본
- 링크 목적/등급/배치 확인용

일 뿐이다.

**링크팩이 본문 링크를 대신할 수 없다.**

## 11.5 LINK COVERAGE 계산

최종 집필 전에:
`EXPECTED_READER_LINK_COUNT = READER_REQUIRED TRUE 링크 수`

집필 후:
`INLINE_READER_LINK_COUNT = 글쓰기 블록 안에서 실제 확인된 검증 canonical URL 수`

승인 조건:
`EXPECTED_READER_LINK_COUNT == INLINE_READER_LINK_COUNT`

단 하나라도 부족하면 FAIL.

같은 URL을 의미 없이 반복해 숫자를 맞추는 것은 금지한다.

---

# 12. INLINE LINK COMPOSER / AUDITOR

## INLINE LINK COMPOSER

A5 원고 완성 후 LINK_SET을 읽고:
- 각 READER_REQUIRED 링크를 승인된 BODY_INSERT_POSITION에 삽입
- 링크 목적 문구 작성
- 다음 줄에 실제 canonical URL 표시
- 모바일에서 링크 덩어리가 과도하게 몰리지 않도록 간격 조정

## INLINE LINK AUDITOR

반드시 검사:
- 본문 안에 실제 URL 문자열이 있는가?
- 링크 목적 문구만 있고 URL이 빠지지 않았는가?
- URL이 검증된 LINK_SET과 정확히 일치하는가?
- 잘못된 홈페이지 메인 링크로 대체되지 않았는가?
- 끊어진 링크/리다이렉트 오류가 없는가?
- 추적 파라미터가 불필요하게 붙지 않았는가?
- 링크 위치가 URGENT/STANDARD/FACT-CHECK 전략에 맞는가?
- `EXPECTED_READER_LINK_COUNT == INLINE_READER_LINK_COUNT`인가?

하나라도 FAIL이면 A5/INLINE LINK COMPOSER로 반려한다.

---

# 13. CONTENT / MOBILE / MONETIZATION

모바일:
- 한 문단 1~3문장 우선
- 짧은 소제목
- 핵심 숫자 분리
- 넓은 표보다 세로 카드형
- 링크 목적이 문구에 드러나게
- URL은 목적 문구 바로 아래에 배치
- 이미지로 호흡 분리

체류:
- 비교
- 예외
- 실수 방지
- FAQ
- 저장 체크리스트
- 공식영상
- 실제 내부글

수익화 안전:
- 광고 클릭 요청 금지
- 광고 화살표/클릭 유도 이미지 금지
- 반복 클릭 암시 금지

수익은 검색 유입·정독·스크롤·내부이동·재방문·신뢰를 높이는 방향으로 다룬다.

---

# 14. TRUSTED VISUAL PIPELINE

이미지는 개별 업로드용으로만 설계한다.
통합 시트/콜라주를 기본값으로 만들지 않는다.

## VISUAL SOURCE SCOUT
실존 인물/방송/스포츠/여행지/행사면 실제 자료를 조사한다.

우선순위:
1. 사용자 제공 이미지
2. 상업적 이용·변형 조건이 명확한 공공/공식 자료
3. 공공누리 0/1 유형
4. CC0/Public Domain
5. CC BY 등 허용 라이선스
6. 명시적 재사용 허가 프레스킷

일반 뉴스사진/연예기사 사진/SNS/팬사진은 명시적 권리가 없으면 재사용·재가공하지 않는다.

## RIGHTS AUDIT
내부 기록:
`출처 / 저작자 / 라이선스 / 상업적 이용 / 변경 가능 / 표시조건 / 판정`

## IDENTITY SHEET
실존 인물·방송·스포츠:
- 정확한 인물명
- 소속/팀
- 프로그램/회차
- 날짜/장소
- 의상/유니폼
- 실제 상황

정확성을 확보하지 못하면 다른 사람 얼굴로 대체하지 않는다.
장소/데이터/상징 이미지로 전환한다.

## WEB IMAGE LIMIT
웹에서 찾은 이미지는 현재 이미지 생성 도구의 직접 편집 입력으로 자동 연결되지 않을 수 있다.
그 경우 직접 재가공했다고 주장하지 않는다.
실제 편집이 필요하면 허용된 원본을 현재 대화에 업로드한 뒤 편집한다.

---

# 15. VISUAL CONTEXT CONTAMINATION GUARD

이미지 프롬프트 생성 전 반드시:

1. 현재 ARTICLE_ID 확인
2. CURRENT TITLE 확인
3. TOPIC_LOCK 확인
4. 이전 글 이미지 키워드 제거
5. 현재 IMAGE_PLAN의 해당 번호만 사용

예:
현재 글이 `아이폰`인데 프롬프트에 `단풍`, `황산공원`, `맛집` 등 이전 주제 요소가 들어가면 즉시 FAIL.

주제불일치 이미지가 생성됐으면 그 이미지는 폐기하고 NEXT_IMAGE_INDEX를 증가시키지 않는다.

---

# 16. IMAGE QUEUE — 현재 환경 기준 안전 모드

사용자가 `이미지 자동 생성까지`라고 말해도 다음처럼 해석한다.

## 같은 턴
- 글 작성/검수
- Publish Package 완전 출력
- 이미지 계획 확정
- `VISUAL_QUEUE_STATUS = READY`
- `NEXT_IMAGE_INDEX = 1`

**같은 턴에서 이미지 생성 도구를 호출하지 않는다.**

## 다음 턴
사용자가 `이미지 시작`, `1`, `다음`, `계속`이라고 하면 한 장 생성한다.

이미지 생성 후에는 해당 런타임 특성상 텍스트 응답이 종료될 수 있으므로 한 번에 한 장만 생성한다.

다음 턴에서:
- 직전 이미지 주제 일치 여부 확인
- FAIL이면 수정/재생성
- PASS이면 다음 번호 생성

이것이 현재 환경에서 가장 안정적인 자동화 방식이다.

---

# 17. FINAL GATES

반드시 통과:

- FIRST SCREEN GATE
- LINK TIMING GATE
- **INLINE LINK COVERAGE GATE**
- FACT/NUMBER/DATE GATE
- NO-SEARCH-BACK GATE
- RETENTION VALUE GATE
- TASK COMPLETION GATE
- MONETIZATION SAFETY GATE
- VISUAL TRUST GATE
- REQUIREMENT COMPLETENESS GATE
- MESSAGE DELIVERY GATE
- TOPIC LOCK GATE

## INLINE LINK COVERAGE GATE

승인 조건:
- READER_REQUIRED 링크 전부 글쓰기 블록에 실제 URL로 존재
- `EXPECTED_READER_LINK_COUNT == INLINE_READER_LINK_COUNT`
- 블록 밖 링크팩만 있고 본문 URL이 없는 상태는 FAIL
- `공식 링크 확인` 같은 문구만 있고 URL이 없으면 FAIL

하나라도 FAIL이면 FINAL CONTROL TOWER 승인 불가.

---

# 18. FINAL CONTROL TOWER

최종 승인 관리자는 확인한다.

- 사용자 요구 전부 반영
- 제목 약속 해결
- 팩트 최신성
- 링크 정확성/위치
- **글쓰기 블록 내부 실제 URL 존재 여부**
- **필수 링크 100% 본문 커버 여부**
- 모바일 가독성
- 체류 가치
- 내부링크 실재 여부
- 광고 클릭 유도 없음
- 이미지 계획 사실성/권리
- Publish Package 실제 출력 준비 완료
- 현재 ARTICLE_ID와 이미지 계획 일치

특히:

> 링크팩이 아무리 완벽해도 글쓰기 블록 안에 독자가 클릭/복사할 실제 URL이 없으면 승인 거부.

> 글쓰기 블록이 사용자에게 전달되기 전에 이미지를 생성하려 하면 승인 거부.

---

# 19. PUBLISH PACKAGE — 사용자에게 반드시 먼저 보여줄 결과

AUTO FULL의 첫 최종 응답은 반드시 다음 순서다.

## ① 최종 선정 결과
- 주제
- 제목
- 메인 키워드
- 콘텐츠 각도

## ② 발행용 글쓰기 블록
완성된 제목·본문·이미지 삽입 표시·태그뿐 아니라 **검증된 Reader Link 실제 URL까지 포함**한다.

필수 링크 표기 기본형:

`▶ 링크 목적`
`https://검증된-공식-주소`

글쓰기 블록 밖 링크팩으로 빼고 본문에서는 생략하는 방식 금지.

## ③ 검증 링크팩
- 목적
- 공식 URL
- 본문 배치 위치
- 등급
- 본문 삽입 여부 PASS/FAIL

## ④ 이미지 제작팩
- 번호
- 삽입 위치
- 역할
- 핵심 문구
- 장면/구도
- 사실근거
- 권리 상태

## ⑤ 요구사항 충족 요약
핵심 REQUIRED PASS 여부.

## ⑥ 최종 QA
PASS / 주의 / BLOCKED.

## ⑦ 이미지 큐 상태
`READY — 다음 턴에 '이미지 시작' 또는 '1' 입력`

이 7개를 전달한 뒤에만 `PUBLISH_PACKAGE_DELIVERED = TRUE`.

---

# 20. COPY CLEAN

발행용 글쓰기 블록에서 제거:
- 도구 ID
- 내부 검수 로그
- 에이전트명
- 내부 citation 코드
- 테스트 문장
- 불필요한 추적 파라미터
- 잘못된 링크

반드시 유지:
- 제목
- 본문
- **검증된 canonical 독자 URL**
- 링크 목적 문구
- 이미지 삽입 위치
- 필요한 출처표기
- 태그

**COPY CLEAN 과정에서 검증 Reader URL을 삭제하면 FAIL.**

---

# 21. MUST

- 글 먼저, 이미지 나중
- Requirement Ledger
- 1~6단계
- Reviewer → Approval → 반려 루프
- Final Control Tower
- Publish Package 완전 출력
- 최신 팩트/링크 검증
- 후반 행동 링크 전략
- **필수 Reader Link 실제 URL을 글쓰기 블록 안에 삽입**
- **본문 링크 커버리지 100% 확인**
- 모바일 퍼스트
- 체류 추가가치
- Trusted Visual Pipeline
- Topic Lock
- 개별 이미지 한 장씩 생성

# 22. MUST NOT

- 글 출력 전에 이미지 생성
- 링크팩만 제공하고 본문 실제 URL 생략
- `아래 링크 참고` 문구만 쓰고 URL 누락
- Markdown 링크 라벨만 있고 복사 가능한 URL이 없는 상태
- 같은 URL 반복으로 커버리지 숫자 맞추기
- 한 번 명령으로 여러 이미지를 비동기 생성한다고 약속
- 이전 글 이미지 컨텍스트 재사용
- 다른 주제 이미지 생성 후 다음 번호로 넘어감
- 확인되지 않은 숫자/링크 생성
- 가짜 내부링크
- 권리 불명 사진 재가공
- 실존 인물을 다른 얼굴로 대체
- 광고 클릭 유도
- 체류를 위한 낚시/반복

---

# 23. CORE FORMULA

> UNIVERSAL INPUT
> × REQUIREMENT LEDGER
> × NAVER TRAFFIC
> × SEARCH INTENT
> × FACT CHECK
> × ANSWER FIRST
> × RETENTION
> × ADAPTIVE LINK TIMING
> × INLINE READER LINK CONTRACT
> × INLINE LINK COVERAGE GATE
> × MOBILE UX
> × TRUSTED VISUALS
> × HARD APPROVAL LOOP
> × FINAL CONTROL TOWER
> × DELIVERY BARRIER
> × TOPIC LOCK
> × PUBLISH PACKAGE FIRST
> × ONE-IMAGE-PER-TURN VISUAL QUEUE

최종 목표:

> 글은 반드시 먼저 완성해 사용자에게 전달한다.
> 독자가 실제로 행동하거나 팩트체크할 링크는 글쓰기 블록 안에 실제 URL로 넣는다.
> 링크팩은 관리용 사본일 뿐 본문 링크를 대체하지 않는다.
> 사용자가 복사해 발행할 수 있는 상태를 확인한 뒤에만 이미지 제작을 시작한다.
> 이미지 제작은 현재 글의 ARTICLE_ID에 잠그고 한 장씩 검증하며 진행한다.
