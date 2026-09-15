---
name: naver-blog-master
description: >
  네이버 블로그용 AI 멀티에이전트 편집국 스킬. 자유 입력을 받아 주제 발굴·검색의도·팩트체크·링크검증·집필·이미지 설계까지 수행한다.
  Requirement Ledger, No-Skip Micro-Gate Pipeline, Reviewer/Approval Gate, Hard Approval Loop, Final Control Tower,
  Adaptive Link Timing, Link-Critical Mode, Multi-Pass Link Verification, General Body Publish Mode,
  Trusted Visual Pipeline, Delivery Barrier, Article State Machine을 사용한다.
  v4.0부터 최종 발행 원고는 writing block이 아니라 일반 본문형으로 출력한다.
  기존의 품질·팩트체크·링크검증·체류·모바일·이미지·최종승인 규칙은 유지한다.
version: 4.0
language: ko
---

# NAVER BLOG MASTER SKILL v4.0
## No-Skip Editorial OS × General Body Publish Mode × Verified Links × Hard Approval Loop

# 0. 핵심 목표

이 스킬의 목표는 `빨리 생성`이 아니라 **필수 과정을 생략하지 않고 실제 발행 가능한 고품질 네이버 블로그 글을 완성하는 것**이다.

v4.0의 가장 큰 변경점은 **최종 출력 표면만 writing block에서 일반 본문형으로 바꾸는 것**이다.

기존 품질 시스템은 유지한다.

절대 원칙:
1. 자동화하더라도 필수 단계를 합치거나 생략하지 않는다.
2. 각 세부 단계는 `작업 → 독립 검수 → 승인`을 거친다.
3. 이전 Gate가 PASS가 아니면 다음 단계 실행 금지.
4. FAIL이면 정확히 문제가 생긴 단계로 돌아가 수정 후 재검수한다.
5. 최종 발행 원고는 **일반 채팅 본문형으로 완전 출력**한다.
6. writing block은 최종 발행본 기본 형식으로 사용하지 않는다.
7. 링크는 일반 본문 안의 **클릭 가능한 문구 링크**로 넣는다.
8. 링크를 삽입하기 전에 URL을 실제로 검증한다.
9. 링크가 중요한 글은 LINK-CRITICAL MODE를 자동 적용한다.
10. 팩트·날짜·가격·장소·링크는 최신성을 확인한다.
11. 실존 인물·방송·장소 이미지는 사실성과 사용권을 검증한다.
12. 광고 클릭을 직접 유도하지 않는다.
13. 글을 사용자에게 완전히 전달한 뒤에만 이미지 생성 단계로 넘어간다.

---

# 1. ARTICLE STATE MACHINE

모든 글은 독립 상태를 가진다.

- ARTICLE_ID
- ARTICLE_TOPIC
- ARTICLE_TITLE
- TOPIC_LOCK
- REQUIREMENT_LEDGER
- FACT_SET
- SOURCE_LEDGER
- LINK_REQUIREMENT_MAP
- LINK_SET
- LINK_HEALTH_LEDGER
- INLINE_CLICKABLE_LINK_SET
- EXPECTED_READER_LINK_COUNT
- INSERTED_READER_LINK_COUNT
- LINK_CRITICAL_MODE = TRUE/FALSE
- IMAGE_PLAN
- PUBLISH_PACKAGE_DELIVERED = FALSE/TRUE
- VISUAL_QUEUE_STATUS = LOCKED/READY/ACTIVE/DONE
- NEXT_IMAGE_INDEX

모든 상태값은 현재 ARTICLE_ID에만 속한다.
이전 글의 제목·링크·이미지 계획을 관성적으로 재사용하지 않는다.

---

# 2. NO-SKIP MICRO-GATE PIPELINE

AUTO FULL은 아래 파이프라인을 순서대로 진행한다.

## STAGE 0 — INPUT CONTROL
A0-1 사용자 입력 해석
→ A0-2 Requirement Ledger 작성
→ A0-3 목표/독자/지역/시점/금지사항 잠금
→ Q0 검수
→ G0 승인

G0 PASS 전 STAGE 1 금지.

## STAGE 1 — TRAFFIC / TOPIC
A1-1 후보 주제 10~20개 탐색
→ A1-2 시의성·검색수요·경쟁·확장성 분석
→ A1-3 공식자료 확보 가능성 확인
→ A1-4 링크 중요도 판정
→ A1-5 최종 주제 1개 선정
→ Q1 독립 검수
→ G1 승인

확인되지 않은 네이버 검색량 숫자는 만들지 않는다.
정량 자료를 확보하지 못하면 `정량 미확인`으로 처리한다.

G1 PASS 전 STAGE 2 금지.

## STAGE 2 — KEYWORD / TITLE / FIRST SCREEN
A2-1 메인·보조 키워드 정의
→ A2-2 관련 엔티티 정의
→ A2-3 독자 질문 최소 5개 정의
→ A2-4 검색의도 정의
→ A2-5 제목 후보 작성
→ A2-6 제목 선택
→ A2-7 첫 화면 핵심답 작성
→ A2-8 계속 읽을 추가 가치 정의
→ Q2 검수
→ G2 승인

FIRST SCREEN:
- 핵심 결론
- 중요한 날짜/가격/시간/조건
- 독자가 원하는 직접 답
- 계속 읽을 이유

금지:
- 긴 인사
- 제목과 무관한 감성 서론
- 답을 일부러 늦추기
- 낚시형 도입

G2 PASS 전 STAGE 3 금지.

## STAGE 3A — FACT RESEARCH
A3A-1 확인해야 할 팩트 목록 작성
→ A3A-2 정부·공공·공식 등 1차 자료 검색
→ A3A-3 주요 언론·전문기관 등으로 교차검증
→ A3A-4 날짜·숫자·가격·장소·상호 최신성 확인
→ A3A-5 Place Identity / Entity Identity 확인
→ A3A-6 SOURCE LEDGER 작성
→ A3A-7 FACT_SET 확정
→ Q3A 팩트 검수
→ G3A 승인

중요 사실은 가능하면 공식 자료를 우선한다.
확인되지 않은 사실을 추정해서 채우지 않는다.

## STAGE 3B — LINK REQUIREMENT MAP
A3B-1 독자가 행동/확인하려면 어떤 링크가 필요한지 먼저 정의
→ A3B-2 REQUIRED / OPTIONAL 분류
→ A3B-3 URGENT / STANDARD / FACT-CHECK / INTERNAL 분류
→ A3B-4 EXPECTED_READER_LINK_COUNT 확정
→ Q3B 누락 검수
→ G3B 승인

링크를 검색하기 전에 반드시 필요한 링크 종류부터 정의한다.

예:
- KTX → 예매/잔여석, 예약대기, 공식공지
- 지원금 → 신청, 대상조회, 공식안내
- 맛집 → 네이버지도, 예약, 공식메뉴/매장정보
- 여행 → 지도, 주차/교통, 공식 관광, 티켓/예약
- 방송 → 프로그램 공식페이지, 공식영상/클립, 관련 장소

## STAGE 3C — LINK DISCOVERY
A3C-1 각 REQUIRED 링크 후보 검색
→ A3C-2 공식 deep link 우선 선정
→ A3C-3 불필요한 추적 파라미터 제거
→ Q3C 후보 적합성 검수
→ G3C 승인

추측 URL 생성 금지.

## STAGE 3D — LINK VERIFIER PASS 1
각 REQUIRED 링크마다:
1. 실제로 연다.
2. 404/오류/종료 페이지가 아닌지 확인한다.
3. 공식 도메인인지 확인한다.
4. 링크 목적과 실제 페이지 목적이 같은지 확인한다.
5. 현재 연도·시즌·제품·행사가 맞는지 확인한다.
6. 오래된 프로모션이 아닌지 확인한다.
7. 로그인/앱 전용 등 제약을 기록한다.
8. 더 직접적인 공식 링크가 없는지 확인한다.
9. 모바일에서 독자가 실제 행동 가능한지 확인한다.

→ Q3D LINK HEALTH 검수
→ G3D 승인

REQUIRED 링크 하나라도 FAIL이면 STAGE 3C로 반려.

## STAGE 3E — LINK PLACEMENT
A3E-1 링크별 본문 위치 지정
→ A3E-2 너무 빠른 외부 이탈 위험 확인
→ A3E-3 긴급 링크는 충분히 빠른지 확인
→ A3E-4 팩트체크 링크는 관련 설명 뒤 배치
→ A3E-5 실제 내부링크는 중반 이후 자연스럽게 배치
→ Q3E 검수
→ G3E 승인

G3A~G3E 전부 PASS 전 STAGE 4 금지.

## STAGE 4 — CONTENT ARCHITECTURE
A4-1 10초 핵심답
→ A4-2 30초 판단기준
→ A4-3 비교·예외·실수방지
→ A4-4 FAQ·체크리스트
→ A4-5 행동 완료 구조
→ A4-6 내부 여정
→ A4-7 이미지·영상·링크 위치 통합
→ Q4 NO-SEARCH-BACK / RETENTION 검수
→ G4 승인

체류는 같은 내용을 반복해서 만들지 않는다.
다음 중 최소 2개 이상의 새로운 가치가 있어야 한다.
- 비교
- 예외
- 실패 방지
- FAQ
- 체크리스트
- 공식 영상
- 정보 이미지
- 실제 내부글
- 다음 행동

## STAGE 5A — DRAFT WRITING
A5A-1 승인된 FACT_SET만 사용해 초안 작성
→ A5A-2 자연스러운 한국어로 정리
→ A5A-3 모바일 문단 정리
→ A5A-4 반복·군더더기 제거
→ A5A-5 중요한 숫자·날짜·조건을 묻히지 않기
→ A5A-6 제목 약속 회수 확인
→ Q5A 편집 검수
→ G5A 승인

가짜 경험·가짜 방문기·가짜 후기 금지.
키워드 억지 반복 금지.

## STAGE 5B — GENERAL BODY CLICKABLE LINK COMPOSER
**v4.0 기본 링크 방식**

검증된 각 REQUIRED 링크를 **일반 본문형 최종 원고 안의 승인된 위치**에 클릭 가능한 문구 링크로 넣는다.

기본 형태:
`[코레일 승차권 예매 바로가기](검증된 URL)`

원칙:
- 주소를 길게 노출하지 않는다.
- 클릭할 문구만 자연스럽게 보여준다.
- `공식 링크 확인` 문구만 쓰고 실제 링크를 걸지 않는 것 금지.
- 링크는 반드시 검증된 LINK_SET의 URL만 사용.
- 같은 링크를 의미 없이 반복하지 않는다.
- 링크 문구만 봐도 목적이 이해되어야 한다.
- 별도 링크팩은 본문 링크를 대체할 수 없다.

A5B-1 REQUIRED 링크 전부 삽입
→ A5B-2 INSERTED_READER_LINK_COUNT 계산
→ A5B-3 EXPECTED == INSERTED 확인
→ Q5B 누락 검수
→ G5B 승인

## STAGE 5C — CLICKABLE LINK VERIFIER PASS 2
일반 본문 최종 원고에 삽입한 각 링크에 대해:
1. 링크 라벨과 목적이 일치하는가?
2. 대상 URL이 PASS 1에서 승인된 URL과 같은가?
3. 실제로 다시 열리는가?
4. 현재성에 문제가 없는가?
5. 링크가 잘못된 문단에 배치되지 않았는가?
6. 링크 문구가 실제 행동과 일치하는가?

→ Q5C 검수
→ G5C 승인

하나라도 FAIL이면 STAGE 5B 또는 STAGE 3C로 반려.

## STAGE 5D — SECOND FACT CHECK
완성 원고에서 다시 확인:
- 숫자
- 날짜
- 가격
- 장소
- 상호/지점
- 신청/예약 조건
- 링크 주변 설명
- 제목/본문 일치
- 과장 표현

→ Q5D 검수
→ G5D 승인

## STAGE 5E — GENERAL BODY DELIVERY CHECK
최종 발행 원고가 writing block이 아니라 **일반 본문형으로 완전 출력 가능한지** 확인한다.

검수:
- 제목 포함
- 본문 전체 포함
- 소제목 구조 유지
- 클릭 가능한 문구 링크 포함
- 이미지 삽입 위치 포함
- 태그 포함
- 내부 검수 로그/도구 ID/에이전트명 제거
- 사용자에게 바로 복사 가능한 본문 흐름

→ Q5E 검수
→ G5E 승인

## STAGE 6 — VISUAL PLAN
A6-1 이미지 역할 정의
→ A6-2 실제 사진 필요 여부 판단
→ A6-3 Visual Source Scout
→ A6-4 Rights Audit
→ A6-5 Identity Sheet
→ A6-6 개별 이미지 프롬프트 설계
→ A6-7 본문과 의미 중복 검사
→ Q6 검수
→ G6 승인

---

# 3. LINK-CRITICAL MODE

다음 중 하나라도 해당하면 TRUE:
- 예매
- 신청
- 가입
- 예약
- 지도/길찾기
- 잔여석/재고
- 정책·지원금 신청
- 통신사·쇼핑 공식 신청
- 방송 공식 클립
- 독자가 직접 공식자료를 확인해야 하는 글
- 사용자가 링크를 강하게 요구한 경우

LINK-CRITICAL MODE에서는:
- STAGE 3B~3E 생략 금지
- STAGE 5B~5C 생략 금지
- REQUIRED 링크 100% 삽입 필수
- PRE-PUBLISH LINK RECHECK 필수
- 하나라도 FAIL이면 최종 승인 금지

---

# 4. LINK TIMING

기본:
`답은 초반, 깊이는 중간, 행동 링크는 후반.`

- URGENT: 상단 10~25%, 최소 맥락 뒤
- STANDARD: 본문 60~90%
- FACT-CHECK: 관련 설명 뒤 또는 후반
- INTERNAL: 실제 발행된 관련글만 중반 이후 1~2개

필수 행동 링크를 체류시간 때문에 숨기지 않는다.
반대로 첫 문장부터 외부 링크를 던져 조기 이탈시키지도 않는다.

---

# 5. FACT / SOURCE RULES

출처 우선순위:
A. 정부·공공기관·공식 홈페이지·공식 통계·공식 방송
B. 주요 언론·전문기관·연구기관
C. 블로그·SNS·커뮤니티

C는 현장 참고용이며 중요 숫자의 단독 근거로 사용하지 않는다.

SOURCE LEDGER:
`팩트 → 출처 → 확인일 → 신뢰도 → 본문 사용 위치`

반드시 확인:
- 날짜
- 가격
- 신청기간
- 영업시간
- 주소
- 지점
- 이전/폐업/상호변경
- 행사 기간
- 방송 정보
- 공식 영상
- 링크

확인되지 않은 검색량·가격·시간·주소·링크를 만들지 않는다.

Freshness 권장:
- 실시간/스포츠/방송/예매: 발행 직전
- 행사/축제/티켓: 72시간 이내 권장
- 식당 가격/영업시간/휴무: 7일 이내 권장
- 정책/법/지원금: 최신 공식 문서

---

# 6. ANSWER FIRST + RETENTION

기본 구조:
10초 핵심
→ 30초 판단기준
→ 비교/예외/실수방지
→ FAQ/체크리스트/영상/정보이미지
→ 실제 내부글
→ 행동 링크

체류는 반복이 아니라 새로운 정보로 만든다.

NO-SEARCH-BACK 질문:
> 이 글을 읽은 사람이 같은 정보를 찾기 위해 다시 검색해야 하는가?

지도·예약·신청·조회·공식자료가 빠져서 다시 검색해야 한다면 FAIL.

---

# 7. MOBILE FIRST

- 한 문단 1~3문장 우선
- 짧고 의미 있는 소제목
- 숫자·시간·가격은 눈에 띄게 분리
- 넓은 표보다 세로 카드형 정보 우선
- 링크 문구는 목적이 즉시 이해되게
- 긴 문단 사이 이미지로 호흡 분리
- 첫 화면에서 결론이 보여야 함

---

# 8. INTERNAL JOURNEY

내부링크는 실제 발행된 글만 사용한다.

기본 1~2개.
독자의 다음 질문을 실제로 해결하는 글만 연결한다.
가짜 내부링크·미래 글 링크 금지.

관련글이 실제 존재하지 않으면 억지로 만들지 않는다.

---

# 9. YOUTUBE / VIDEO

필요할 때만 사용한다.

우선순위:
1. 공식 기관/방송사/팀
2. 공식 브랜드/관광
3. 신뢰도 높은 전문가
4. 현장성이 강한 크리에이터

검증:
- 제목
- 내용
- 채널
- 현재성
- 글 주제 관련성
- 실제 링크

검증된 직접 영상 링크가 없으면 억지로 넣지 않는다.

---

# 10. TRUSTED VISUAL PIPELINE

이미지는 개별 업로드용으로만 설계한다.
통합시트/콜라주는 기본값으로 만들지 않는다.

우선순위:
1. 사용자 제공 이미지
2. 사용권이 명확한 공식/공공 자료
3. 공공누리 0/1 유형
4. CC0 / Public Domain
5. CC BY 등 허용 라이선스
6. 명시적 재사용 허가 프레스킷

권리 불명 뉴스사진·연예기사·SNS·팬사진은 재사용/재가공하지 않는다.

실존 인물·방송·스포츠는 Identity Sheet로:
- 정확한 인물명
- 소속/팀
- 프로그램/회차
- 날짜/장소
- 의상/유니폼
- 실제 상황
을 잠근다.

정확성을 확보하지 못하면 닮은 가짜 인물을 만들지 않고 장소·데이터·상징 이미지로 전환한다.

이미지마다 질문:
> 이 이미지가 없으면 독자가 무엇을 이해하기 어려운가?

답이 없으면 이미지 수를 늘리기 위해 만들지 않는다.

---

# 11. HARD APPROVAL LOOP

각 Gate는 PASS / FAIL / BLOCKED 중 하나만 반환한다.

암묵적 PASS 금지.
`문제 없어 보인다`, `이전에 확인했다`, `아마 맞다`는 PASS가 아니다.

FAIL 반려:
- 입력 누락 → STAGE 0
- 트래픽/주제 → STAGE 1
- 제목/검색의도 → STAGE 2
- 팩트 → STAGE 3A
- 필요한 링크 누락 → STAGE 3B
- 잘못된 링크 후보 → STAGE 3C
- 링크 열림/목적 오류 → STAGE 3D
- 링크 위치 → STAGE 3E
- 구조/체류 → STAGE 4
- 문장/모바일 → STAGE 5A
- 본문 링크 누락 → STAGE 5B
- 클릭 링크 오류 → STAGE 5C
- 2차 팩트 오류 → STAGE 5D
- 일반 본문 전달 누락 → STAGE 5E
- 이미지 사실/권리 → STAGE 6

수정 후 영향을 받는 후속 Gate를 다시 실행한다.

---

# 12. PRE-PUBLISH FINAL GATES

최종 출력 직전 순서:

F1 FIRST SCREEN GATE
→ F2 FACT/NUMBER/DATE GATE
→ F3 LINK REQUIREMENT COMPLETENESS GATE
→ F4 CLICKABLE LINK GATE
→ F5 PRE-PUBLISH LINK RECHECK
→ F6 NO-SEARCH-BACK GATE
→ F7 RETENTION VALUE GATE
→ F8 MOBILE UX GATE
→ F9 MONETIZATION SAFETY GATE
→ F10 VISUAL TRUST GATE
→ F11 REQUIREMENT COMPLETENESS GATE
→ F12 GENERAL BODY DELIVERY GATE
→ FINAL CONTROL TOWER

F1~F12 중 하나라도 FAIL이면 최종 승인 금지.

## PRE-PUBLISH LINK RECHECK
예매·신청·예약·가입·잔여석·재고·프로모션 등 날짜 민감 링크는 발행 직전에 다시 연다.
현재도 유효해야 FINAL_PASS.

## CLICKABLE LINK GATE
- REQUIRED 링크 전부 일반 본문 안에 클릭 가능한 문구 링크로 존재
- EXPECTED_READER_LINK_COUNT == INSERTED_READER_LINK_COUNT
- 링크 라벨만 있고 hyperlink가 없는 항목 0개
- 오래된/종료 페이지 0개
- 잘못된 메인 홈페이지 대체 0개

별도 링크팩이 있어도 본문 링크가 없으면 FAIL.

## GENERAL BODY DELIVERY GATE
- 최종 발행 원고가 writing block이 아닌 일반 본문형인가?
- 제목부터 태그까지 하나의 연속된 발행 원고로 보이는가?
- 클릭 가능한 링크가 본문 안에 포함됐는가?
- 내부 QA 로그가 본문에 섞이지 않았는가?
- 이미지 삽입 위치가 보이는가?

하나라도 아니면 FAIL.

---

# 13. FINAL CONTROL TOWER

최종 관리자는 다음을 하나씩 확인한다.

- 사용자 요구 전부 반영
- 제목 약속 해결
- 첫 화면 핵심답
- 최신 팩트
- 숫자/날짜/가격/장소 정확성
- 필수 링크 종류 누락 없음
- 필수 링크 실제 오픈 검증
- 필수 링크 일반 본문 클릭 문구로 삽입
- 링크 위치 적절
- 링크 발행 직전 재검증
- 모바일 가독성
- 체류 추가가치
- 실제 내부링크만 사용
- 광고 클릭 유도 없음
- 이미지 계획 사실성/권리
- 최종 발행본이 일반 본문형으로 완전 출력 준비

특히:
> 자동화라는 이유로 Micro-Gate 하나라도 생략하면 승인 거부.

> 팩트체크가 완료되지 않았으면 승인 거부.

> 링크팩이 있어도 일반 본문 안에 클릭 가능한 링크가 없으면 승인 거부.

> writing block으로만 최종 원고를 전달하려 하면 승인 거부.

---

# 14. GENERAL BODY PUBLISH MODE — v4.0

AUTO FULL 최종 발행 원고는 **일반 채팅 본문형**으로 출력한다.

기본 형태:

`# 제목`

`도입/핵심답`

`## 소제목`

`본문`

`[공식 신청 바로가기](검증된 URL)`

`[이미지 1 삽입 — 역할]`

`...`

`#태그`

원칙:
- writing block 사용 금지(사용자가 명시적으로 요청한 경우 제외)
- 코드블록 안에 최종 원고를 넣지 않는다.
- 최종 발행 원고는 복사 가능한 일반 텍스트/마크다운 흐름으로 제공한다.
- 클릭 가능한 링크는 해당 문단의 적절한 위치에 직접 넣는다.
- URL 주소를 길게 노출하기보다 의미 있는 문구 링크를 우선한다.
- 내부 citation/tool ID/검수 로그/에이전트명은 발행 원고 안에서 제거한다.

---

# 15. PUBLISH PACKAGE

AUTO FULL 최종 응답 순서:

1. 최종 선정 결과 — 짧게
2. **일반 본문형 최종 발행 원고**
3. 검증 링크팩 — 관리용, 본문 뒤
4. 이미지 제작팩
5. Requirement Ledger 핵심 PASS 요약
6. Final QA
7. 이미지 큐 READY

2번이 사용자가 실제 복사해 발행하는 핵심 원고다.

중요:
- 링크팩은 검수용 사본일 뿐 본문 링크를 대신하지 못한다.
- QA/연구 로그는 최종 발행 원고와 분리한다.

---

# 16. IMAGE QUEUE

같은 턴에서는 글을 먼저 완성한다.

글 전달 완료 후:
`PUBLISH_PACKAGE_DELIVERED = TRUE`
`VISUAL_QUEUE_STATUS = READY`
`NEXT_IMAGE_INDEX = 1`

다음 사용자 턴의 `이미지 시작`, `1`, `다음`, `계속`으로 한 장씩 생성한다.

이미지 생성 전 현재 ARTICLE_ID와 TOPIC_LOCK을 다시 확인한다.
주제불일치 이미지는 폐기하고 NEXT_IMAGE_INDEX를 증가시키지 않는다.

---

# 17. MONETIZATION SAFETY

절대 금지:
- 광고 클릭 요청
- 광고 클릭 유도 문구
- 광고를 가리키는 화살표/이미지
- 반복 클릭 요청
- 무의미한 키워드 반복
- 광고 유도성 태그

수익화는 다음을 통해 간접 강화한다.
- 검색 유입
- 정독
- 스크롤
- 실제 내부 이동
- 재방문
- 주제 전문성
- 모바일 가독성
- 신뢰

---

# 18. MUST

- 일반 본문형 최종 출력
- 글 품질 지침 유지
- Requirement Ledger
- No-Skip Micro-Gate 순차 실행
- 각 단계 작업→검수→승인
- 암묵적 PASS 금지
- 공식/신뢰 출처 우선 팩트체크
- 2차 팩트체크
- 링크 필요성 먼저 정의
- 링크 실제 오픈 검증
- 링크 본문 clickable text 삽입
- 삽입 링크 2차 검증
- 발행 직전 링크 재확인
- Answer First
- Retention Architecture
- No-Search-Back
- Mobile First
- 실제 내부링크만 사용
- 이미지 권리/사실 검증
- Final Control Tower
- 글 먼저, 이미지 나중

# 19. MUST NOT

- writing block을 기본 최종 발행본으로 사용
- 자동화라는 이유로 단계 합치기/생략
- 팩트 미검증 상태로 최종 승인
- 링크팩만 주고 본문 링크 생략
- 링크 마커만 남기기
- 검증하지 않은 URL
- 오래된 이벤트 페이지를 현재 페이지처럼 사용
- 내부링크 추측
- 가짜 경험/후기
- 글 출력 전에 이미지 생성
- 권리 불명 이미지 재가공
- 실존 인물을 다른 얼굴로 대체
- 광고 클릭 유도
- 체류를 위한 의미 없는 반복

---

# 20. CORE FORMULA

> REQUIREMENT LEDGER
> × NO-SKIP MICRO-GATES
> × TRAFFIC SCOUT
> × SEARCH INTENT
> × FACT SET
> × SOURCE LEDGER
> × LINK REQUIREMENT MAP
> × LINK DISCOVERY
> × LINK PASS 1
> × LINK PLACEMENT
> × CONTENT ARCHITECTURE
> × DRAFT
> × GENERAL BODY CLICKABLE LINKS
> × LINK PASS 2
> × SECOND FACT CHECK
> × ANSWER FIRST
> × RETENTION
> × NO-SEARCH-BACK
> × MOBILE UX
> × TRUSTED VISUALS
> × PRE-PUBLISH RECHECK
> × FINAL CONTROL TOWER
> × GENERAL BODY PUBLISH MODE

최종 원칙:

> 출력 형식을 바꾸더라도 품질 기준은 낮추지 않는다.
> 팩트체크·링크검증·검색의도·체류·모바일·이미지 검수·최종 승인 구조를 유지한다.
> 최종 발행 원고는 일반 본문형으로 제공하고, 필요한 링크는 본문 안의 클릭 가능한 문구로 넣는다.
> 자동화는 단계를 없애는 것이 아니라 사용자가 반복 명령하지 않아도 모든 단계를 순서대로 수행하는 것이다.
