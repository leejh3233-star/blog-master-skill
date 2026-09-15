---
name: naver-blog-master
description: >
  네이버 블로그용 AI 멀티에이전트 편집국 스킬. 자유 입력을 받아 주제 발굴·검색의도·팩트체크·링크검증·집필·이미지 설계까지 수행한다.
  Requirement Ledger, Micro-Gate Pipeline, Reviewer/Approval Gate, Hard Approval Loop, Final Control Tower,
  Adaptive Link Timing, Link-Critical Mode, Multi-Pass Link Verification, Inline Clickable Link Gate,
  Trusted Visual Pipeline, Delivery Barrier, Article State Machine을 사용한다.
  v3.9부터 자동화 과정의 생략을 막기 위해 각 대단계를 세부 단계로 분리하고, 필수 체크포인트가 PASS되지 않으면 다음 단계로 진행하지 않는다.
  링크는 글쓰기 블록 안의 '클릭 가능한 문구 링크'를 기본값으로 사용한다.
version: 3.9
language: ko
---

# NAVER BLOG MASTER SKILL v3.9
## Micro-Gate Editorial OS × Inline Clickable Links × Hard Approval Loop

# 0. 핵심 목표

이 스킬의 목표는 `한 번에 빨리 생성`이 아니라 **필수 과정을 생략하지 않고 실제 발행 가능한 글을 완성하는 것**이다.

가장 중요한 원칙:

1. 자동화하더라도 필수 단계는 합치거나 생략하지 않는다.
2. 각 세부 단계는 `작업 → 독립 검수 → 승인`을 거친다.
3. 이전 단계가 PASS가 아니면 다음 단계 실행 금지.
4. FAIL이면 정확히 문제가 생긴 단계로 돌아가 수정 후 다시 검수한다.
5. 최종 글은 사용자에게 먼저 완전 전달하고 이미지는 다음 사용자 턴부터 진행한다.
6. 링크는 기본적으로 **주소를 길게 노출하지 않고, 글쓰기 블록 안의 문구 자체에 클릭 가능한 링크를 건다.**
7. 클릭 링크를 만들기 전에 URL을 실제로 검증한다.
8. 링크가 중요한 글은 LINK-CRITICAL MODE를 자동 적용한다.
9. 실존 인물·방송·장소 이미지는 사실성과 사용권을 검증한다.
10. 광고 클릭을 직접 유도하지 않는다.

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

G1 PASS 전 STAGE 2 금지.

## STAGE 2 — KEYWORD / TITLE / FIRST SCREEN
A2-1 메인·보조 키워드 정의
→ A2-2 독자 질문 최소 5개 정의
→ A2-3 검색의도 정의
→ A2-4 제목 후보 작성
→ A2-5 제목 선택
→ A2-6 첫 화면 핵심답 작성
→ A2-7 계속 읽을 추가 가치 정의
→ Q2 검수
→ G2 승인

G2 PASS 전 STAGE 3 금지.

## STAGE 3A — FACT RESEARCH
A3A-1 확인해야 할 팩트 목록 작성
→ A3A-2 공식 1차 자료 검색
→ A3A-3 보조 자료 교차검증
→ A3A-4 날짜·숫자·가격·장소 최신성 확인
→ A3A-5 Place Identity / Entity Identity 확인
→ A3A-6 FACT_SET 확정
→ Q3A 팩트 검수
→ G3A 승인

## STAGE 3B — LINK REQUIREMENT MAP
A3B-1 독자가 행동/확인하려면 어떤 링크가 필요한지 먼저 정의
→ A3B-2 각 링크를 REQUIRED / OPTIONAL로 분류
→ A3B-3 URGENT / STANDARD / FACT-CHECK / INTERNAL 분류
→ A3B-4 EXPECTED_READER_LINK_COUNT 확정
→ Q3B 누락 검수
→ G3B 승인

**링크를 찾기 전에 반드시 필요한 링크 종류부터 정의한다.**
이 단계가 없으면 링크 검증을 시작하지 않는다.

## STAGE 3C — LINK DISCOVERY
A3C-1 각 REQUIRED 링크 후보 검색
→ A3C-2 공식 deep link 우선 선정
→ A3C-3 불필요한 추적 파라미터 제거
→ Q3C 후보 적합성 검수
→ G3C 승인

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

→ Q3D LINK HEALTH 검수
→ G3D 승인

REQUIRED 링크 하나라도 FAIL이면 STAGE 3C로 반려.

## STAGE 3E — LINK PLACEMENT
A3E-1 링크별 본문 위치 지정
→ A3E-2 너무 빠른 외부 이탈 위험 확인
→ A3E-3 긴급 링크는 충분히 빠른지 확인
→ A3E-4 팩트체크 링크는 관련 설명 뒤 배치
→ Q3E 검수
→ G3E 승인

G3A~G3E 전부 PASS 전 STAGE 4 금지.

## STAGE 4 — CONTENT ARCHITECTURE
A4-1 10초 핵심답
→ A4-2 30초 판단기준
→ A4-3 비교·예외·실수방지
→ A4-4 FAQ·체크리스트
→ A4-5 내부 여정
→ A4-6 이미지·영상·링크 위치 통합
→ Q4 NO-SEARCH-BACK / RETENTION 검수
→ G4 승인

## STAGE 5A — DRAFT WRITING
A5A-1 승인된 FACT_SET만 사용해 초안 작성
→ A5A-2 모바일 문단 정리
→ A5A-3 반복·군더더기 제거
→ A5A-4 제목 약속 회수 확인
→ Q5A 편집 검수
→ G5A 승인

## STAGE 5B — INLINE CLICKABLE LINK COMPOSER
**v3.9 기본 링크 방식**

검증된 각 REQUIRED 링크를 글쓰기 블록 안의 승인된 위치에:

`[코레일 승차권 예매 바로가기](검증된 URL)`

처럼 **문구 자체가 클릭되는 링크**로 넣는다.

기본 규칙:
- 긴 raw URL을 본문에 노출하지 않는다.
- `공식 링크 확인` 같은 문구만 쓰고 링크를 걸지 않는 것 금지.
- 링크는 반드시 검증된 LINK_SET의 URL만 사용.
- 같은 링크를 불필요하게 반복하지 않는다.
- 사용자에게 가장 이해하기 쉬운 행동 문구를 사용한다.

A5B-1 REQUIRED 링크 전부 삽입
→ A5B-2 INSERTED_READER_LINK_COUNT 계산
→ A5B-3 EXPECTED == INSERTED 확인
→ Q5B 누락 검수
→ G5B 승인

## STAGE 5C — CLICKABLE LINK VERIFIER PASS 2
글쓰기 블록에 삽입한 각 링크에 대해:
1. 링크 라벨과 목적이 일치하는가?
2. 대상 URL이 PASS 1에서 승인된 URL과 같은가?
3. 실제로 다시 열리는가?
4. 현재성에 문제가 없는가?
5. 링크가 다른 문단으로 잘못 이동하지 않았는가?

→ Q5C 검수
→ G5C 승인

하나라도 FAIL이면 STAGE 5B 또는 STAGE 3C로 반려.

## STAGE 5D — SECOND FACT CHECK
완성 원고에서:
- 숫자
- 날짜
- 가격
- 장소
- 링크 주변 설명
- 제목/본문 일치
을 다시 검증한다.

→ Q5D 검수
→ G5D 승인

## STAGE 6 — VISUAL PLAN
A6-1 이미지 역할 정의
→ A6-2 실제 사진 필요 여부 판단
→ A6-3 Visual Source Scout
→ A6-4 Rights Audit
→ A6-5 Identity Sheet
→ A6-6 개별 이미지 프롬프트 설계
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

체류를 위해 필수 링크를 숨기지 않는다.
반대로 첫 문장부터 외부 링크를 던져 조기 이탈시키지도 않는다.

---

# 5. CLICKABLE LINK GATE

최종 글쓰기 블록은 다음을 만족해야 한다.

- REQUIRED 링크가 모두 클릭 가능한 문구 링크로 존재
- EXPECTED_READER_LINK_COUNT == INSERTED_READER_LINK_COUNT
- 링크 라벨만 있고 실제 hyperlink가 없는 항목 0개
- 잘못된 메인 홈페이지 대체 0개
- 오래된/종료된 페이지 0개
- LINK-CRITICAL이면 모든 링크 FINAL_PASS

**별도 링크팩이 존재해도 글쓰기 블록 안 클릭 링크가 없으면 FAIL.**

TXT/HTML export는 기본 출력이 아니다.
사용자가 요청하거나 현재 surface에서 클릭 링크 렌더링이 실제로 실패한 경우에만 fallback으로 사용한다.

---

# 6. FACT / SOURCE RULES

출처 우선순위:
A. 정부·공공기관·공식 홈페이지·공식 통계·공식 방송
B. 주요 언론·전문기관·연구기관
C. 블로그·SNS·커뮤니티

C는 중요 숫자의 단독 근거로 사용하지 않는다.

SOURCE LEDGER:
`팩트 → 출처 → 확인일 → 신뢰도 → 본문 사용 위치`

확인되지 않은 검색량·가격·시간·주소·링크를 만들지 않는다.

---

# 7. ANSWER FIRST + RETENTION

구조:
10초 핵심
→ 30초 판단기준
→ 비교/예외/실수방지
→ FAQ/체크리스트/영상/정보이미지
→ 실제 내부글
→ 행동 링크

체류는 반복이 아니라 새로운 정보로 만든다.

---

# 8. MOBILE FIRST

- 1~3문장 문단 우선
- 짧은 소제목
- 숫자·시간·가격 분리
- 넓은 표보다 세로 카드
- 링크 문구는 목적이 즉시 이해되게
- 이미지로 긴 문단 호흡 분리

---

# 9. TRUSTED VISUAL PIPELINE

개별 이미지 전용. 통합시트 기본 금지.

우선순위:
1. 사용자 제공 이미지
2. 사용권이 명확한 공식/공공 자료
3. 공공누리 0/1
4. CC0 / Public Domain
5. CC BY
6. 명시적 프레스킷

권리 불명 뉴스사진·연예기사·SNS·팬사진 재사용/재가공 금지.

실존 인물·방송·스포츠는 Identity Sheet로:
- 인물명
- 소속/팀
- 프로그램/회차
- 날짜/장소
- 의상/유니폼
- 실제 상황
을 잠근다.

정확성을 확보하지 못하면 닮은 가짜 인물을 만들지 않고 장소·데이터·상징 이미지로 전환한다.

---

# 10. HARD APPROVAL LOOP

각 Gate는 PASS / FAIL / BLOCKED 중 하나만 반환한다.

**암묵적 PASS 금지.**
`문제 없어 보인다`는 PASS가 아니다.
체크리스트 항목을 실제 확인해야 PASS다.

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
- 이미지 사실/권리 → STAGE 6

수정 후 영향을 받는 후속 Gate를 다시 실행한다.

---

# 11. PRE-PUBLISH FINAL GATES

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
→ F12 MESSAGE DELIVERY GATE
→ FINAL CONTROL TOWER

F1~F12 중 하나라도 FAIL이면 최종 승인 금지.

## PRE-PUBLISH LINK RECHECK
특히 예매·신청·예약·가입·잔여석·재고·프로모션 링크를 발행 직전에 다시 연다.
현재도 유효해야 FINAL_PASS.

---

# 12. FINAL CONTROL TOWER

최종 관리자는 다음을 1개씩 체크한다.

- 사용자 요구 전부 반영
- 제목 약속 해결
- 첫 화면 핵심답
- 최신 팩트
- 필수 링크 종류 누락 없음
- 필수 링크 실제 오픈 검증
- 필수 링크 본문 클릭 문구로 삽입
- 링크 위치 적절
- 링크 발행 직전 재검증
- 모바일 가독성
- 체류 추가가치
- 실제 내부링크만 사용
- 광고 클릭 유도 없음
- 이미지 계획 사실성/권리
- 글쓰기 블록 완전 출력 준비

특히:
> 링크팩이 있어도 글쓰기 블록 안에 클릭 가능한 링크가 없으면 승인 거부.

> 자동화라는 이유로 Micro-Gate 하나라도 생략하면 승인 거부.

---

# 13. PUBLISH PACKAGE

AUTO FULL 최종 응답 순서:

1. 최종 선정 결과
2. **클릭 가능한 문구 링크가 포함된 하나의 발행용 글쓰기 블록**
3. 검증 링크팩(관리용)
4. 이미지 제작팩
5. Requirement Ledger 핵심 PASS 요약
6. Final QA
7. 이미지 큐 READY

글쓰기 블록이 실사용 최종 원고다.
링크팩은 검수용 사본일 뿐 본문 링크를 대신하지 못한다.

---

# 14. IMAGE QUEUE

같은 턴에서는 글만 완성한다.

글 전달 완료 후:
`PUBLISH_PACKAGE_DELIVERED = TRUE`
`VISUAL_QUEUE_STATUS = READY`
`NEXT_IMAGE_INDEX = 1`

다음 사용자 턴의 `이미지 시작`, `1`, `다음`, `계속`으로 한 장씩 생성한다.

---

# 15. MUST

- Micro-Gate 순차 실행
- 각 단계 작업→검수→승인
- 암묵적 PASS 금지
- 링크 필요성 먼저 정의
- 링크 실제 오픈 검증
- 링크 본문 clickable text 삽입
- 삽입 링크 2차 검증
- 발행 직전 링크 재확인
- 글쓰기 블록을 최종 원고로 제공
- 글 먼저, 이미지 나중
- Final Control Tower

# 16. MUST NOT

- 자동화라는 이유로 단계 합치기/생략
- 링크팩만 주고 본문 링크 생략
- `[공식 링크 L1]` 같은 마커만 남기기
- raw URL 파일을 기본값으로 사용
- 검증하지 않은 URL
- 오래된 이벤트 페이지
- 내부링크 추측
- 글 출력 전에 이미지 생성
- 권리 불명 이미지 재가공
- 실존 인물을 다른 얼굴로 대체
- 광고 클릭 유도

---

# 17. CORE FORMULA

> REQUIREMENT LEDGER
> × NO-SKIP MICRO-GATES
> × TRAFFIC SCOUT
> × SEARCH INTENT
> × FACT SET
> × LINK REQUIREMENT MAP
> × LINK DISCOVERY
> × LINK PASS 1
> × LINK PLACEMENT
> × CONTENT ARCHITECTURE
> × DRAFT
> × INLINE CLICKABLE LINKS
> × LINK PASS 2
> × SECOND FACT CHECK
> × VISUAL TRUST
> × PRE-PUBLISH RECHECK
> × FINAL CONTROL TOWER

최종 원칙:

> 자동화는 단계를 없애는 것이 아니라 사용자가 명령을 반복하지 않아도 모든 단계를 순서대로 자동 실행하는 것이다.
> 각 필수 단계는 독립 검수와 승인 없이는 다음 단계로 넘어가지 않는다.
> 링크는 글쓰기 블록 안에서 주소가 아닌 클릭 가능한 문구로 제공하는 것을 기본으로 한다.
