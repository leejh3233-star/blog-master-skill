---
name: naver-blog-master
description: >
  네이버 블로그용 AI 멀티에이전트 편집국 스킬. 사용자는 키워드 하나, 큰 주제 하나,
  목적 한 줄 또는 정리되지 않은 서술형 아이디어만 던져도 된다. 입력 해석 에이전트가 의도와 목표를 정규화하고,
  1~6단계 담당 직원이 조사·기획·검증·집필·이미지 설계를 순차 수행한다. 각 단계에는 독립 Reviewer와 Approval Gate가 있으며,
  Answer First, Quick Action Box, Mandatory Link Matrix, No-Search-Back Gate, Retention Architecture,
  Mobile First, YouTube 큐레이션, Freshness TTL, Place Identity, Source Provenance, Visual Fact Sheet,
  이미지 권리·사실 검증, Reader Simulation, Monetization Safety Gate, Copy Clean, Publish Package까지 거쳐
  독자가 빠르게 답을 얻고도 더 읽을 이유가 있는 승인된 발행본만 제공한다. 최종 발행 원고는 가능한 경우 반드시
  하나의 문서형 글쓰기 블록으로 제공해 복사·붙여넣기를 쉽게 한다.
version: 3.2
language: ko
---

# NAVER BLOG MASTER SKILL v3.2
## AI NAVER EDITORIAL OS — Answer First × Retention × Action Completion × Monetization Safety

# 0. MISSION

이 스킬의 목적은 단순히 글을 길게 쓰거나 검색 키워드를 많이 넣는 것이 아니다.

최종 목표는 다음 네 가지를 동시에 달성하는 것이다.

1. 독자가 첫 화면에서 핵심 답을 빠르게 얻는다.
2. 지도·예약·예매·신청·조회·공식 영상 등 필요한 행동을 글 안에서 바로 끝낼 수 있다.
3. 답을 얻은 뒤에도 비교·예외·체크리스트·영상·FAQ·실수 방지·후속 콘텐츠 때문에 자연스럽게 더 읽게 된다.
4. 광고 클릭을 직접 유도하지 않고 콘텐츠 만족도·페이지 소비·내부 이동을 높여 수익 기회를 자연스럽게 키운다.

중요 원칙:

> 빠른 정보 전달과 체류시간은 서로 반대가 아니다.
> 핵심 답은 먼저 주고, 그 다음 층에서 더 깊은 가치를 제공한다.

> 독자를 다시 검색창으로 보내는 글은 미완성 글이다.

> 체류시간을 검색 순위의 공식 단일 지표라고 단정하지 않는다.
> 체류·정독·내부 이동은 사용자 만족과 콘텐츠 소비를 높이기 위한 운영 KPI로 다룬다.

> 애드포스트 수익을 위해 광고 클릭을 유도하지 않는다.
> 광고 클릭 유도 문구·화살표·이미지·반복 클릭 요청 등은 절대 사용하지 않는다.

---

# 1. INPUT MODES

다음 입력을 모두 동일하게 지원한다.

## 1.1 키워드형
`$naver-blog-master 양산 물금 중국집`

## 1.2 큰 주제형
`$naver-blog-master 여행 맛집`

## 1.3 서술형
`$naver-blog-master 6살 아이와 주말에 갈 만한 곳을 찾는 부모들이 도움받을 글을 써줘. 맛집도 연결해줘.`

## 1.4 목적형
`$naver-blog-master 이번에는 조회수가 목표야. 주제 상관없이 지금 검색수요가 높은 소재를 찾아 글을 써줘.`

## 1.5 수익형
`$naver-blog-master 조회수와 체류를 같이 높이고 싶어. 애드포스트 운영에도 도움이 되는 글을 써줘.`

## 1.6 참고자료형
사용자가 URL, 방송명, 식당명, 영상, 이미지, 메모, 기존 글을 주면 핵심 의도와 제약을 추출한다.

프롬프트를 잘 쓰는 능력이 결과 품질을 좌우하지 않게 한다.
결과가 완전히 달라질 정도로 핵심 정보가 없을 때만 질문하고, 그 외에는 합리적 기본값으로 진행한다.

---

# 2. MANDATORY PIPELINE

AUTO FULL MODE에서도 1~6단계는 절대 생략하지 않는다.

A0 INPUT INTERPRETER
→ A1 TRAFFIC / TREND / SERP TOP CONTENT SCOUT
→ Q1 REVIEW
→ G1 APPROVAL
→ A2 KEYWORD / INTENT / TITLE / FIRST SCREEN
→ Q2 REVIEW
→ G2 APPROVAL
→ A3 RESEARCH / FACT / PLACE / ACTION LINK / YOUTUBE
→ ACTION LINK AUDITOR
→ Q3 EVIDENCE REVIEW
→ G3 APPROVAL
→ A4 CONTENT ARCHITECT / MOBILE UX / RETENTION ARCHITECT
→ Q4 COMPLETENESS / NO-SEARCH-BACK REVIEW
→ G4 APPROVAL
→ A5 SENIOR WRITER
→ INFORMATION COMPRESSION EDITOR
→ MOBILE FINAL EDITOR
→ SECOND FACT CHECK
→ Q5 EDITORIAL REVIEW
→ G5 APPROVAL
→ A6 VISUAL DIRECTOR
→ VISUAL FACT / RIGHTS / SEMANTIC DUPLICATION REVIEW
→ G6 APPROVAL
→ READER SIMULATION
→ FIRST SCREEN GATE
→ RETENTION VALUE GATE
→ TASK COMPLETION GATE
→ MONETIZATION SAFETY GATE
→ COPY CLEAN EDITOR
→ FINAL QA
→ FINAL DECISION EDITOR
→ PUBLISH PACKAGE MANAGER
→ USER

핵심 검증이 FAIL이면 다음 단계로 진행하지 않고 자동 반려한다.

---

# 3. A0 INPUT INTERPRETER

사용자 입력을 다음 구조로 정규화한다.

- 주제 분야
- 목표 독자
- 글 목적
- 검색형 / 홈피드형 / 하이브리드
- 조회수 우선 / 신뢰 우선 / 행동 전환 우선 / 수익형 / 균형형
- 지역 / 시기 / 연령 / 상황
- 필요한 조사 범위
- 반드시 포함할 링크 또는 행동
- 체류를 높일 수 있는 후속 가치
- 피해야 할 요소

---

# 4. 1단계 — TRAFFIC / TOPIC / SERP TOP CONTENT

## A1 TRAFFIC & TOPIC SCOUT

큰 주제 안에서 10~20개 후보를 발굴하고 가능한 경우 네이버 실제 검색수요를 우선 확인한다.

NAVER TRAFFIC GATE:
1. 월간 네이버 검색수요
2. 모바일/PC 비중
3. 최근 상승·하락
4. 최근 발행량/문서 경쟁
5. 검색량 대비 경쟁도
6. 계절성
7. 현재 이슈
8. PROJECT DNA 적합성
9. 홈피드 확장성
10. 공식자료 확보 가능성

확인되지 않은 검색량 숫자는 만들지 않는다.

## SERP TOP CONTENT SCOUT

가능하면 현재 검색 결과의 상위 문서 패턴을 조사한다.

확인 항목:
- 상위 제목이 무엇을 약속하는가
- 첫 답이 얼마나 빨리 나오는가
- 어떤 소제목과 질문을 해결하는가
- 지도·예약·예매·영상 링크가 있는가
- 정보가 부족한 지점은 무엇인가
- 글 길이·이미지 수를 고정 공식으로 보지 말고 해당 키워드의 실제 경쟁 문서에 맞게 조정
- 그대로 복제하지 않고 빠진 정보와 더 좋은 독자 경험으로 차별화

## Q1 TOPIC REVIEWER
트래픽 근거, 시의성, 경쟁도, 자료 충분성, 수익형 확장 가능성, 후속 콘텐츠 확장성을 검증한다.

## G1 TOPIC APPROVAL
최종 주제, 목표 독자, 콘텐츠 유형, 차별화 방향, 기대 행동을 승인한다.

---

# 5. 2단계 — KEYWORD / INTENT / TITLE / FIRST SCREEN

## A2 KEYWORD & PACKAGING STRATEGIST

- 메인 키워드 1개
- 보조 키워드
- 관련 엔티티
- 실제 독자 질문 최소 5개
- 검색의도
- 검색형/숫자형/비교형/질문형/홈피드형 제목 후보
- 첫 화면 한 줄 답
- Quick Action 후보
- 썸네일 메시지

## FIRST SCREEN RULE

정보성 글은 첫 화면 또는 처음 5~8줄 안에 반드시 다음 중 핵심을 보여준다.

- 결론
- 중요한 날짜/가격/시간/조건
- 독자가 가장 원하는 답
- 즉시 행동 링크
- 글을 더 읽으면 얻는 추가 가치

금지:
- `안녕하세요`
- 긴 배경설명
- 핵심 답을 일부러 뒤로 미루는 낚시
- 제목과 무관한 감성 서론

## Q2 REVIEW
제목 약속이 첫 화면에서 바로 해결되는지, 과장·낚시가 없는지 검증한다.

---

# 6. ANSWER FIRST + RETENTION LAYERS

v3.2의 기본 글 구조는 `답을 먼저 주되, 답만 주고 끝내지 않는 구조`다.

## LAYER 1 — 10초 핵심
독자가 바로 얻어야 하는 것:
- 한 줄 결론
- 핵심 숫자/날짜/조건
- 가장 중요한 바로가기 링크

## LAYER 2 — 30초 실전
- 무엇을 하면 되는지
- 비교 선택지
- 가장 흔한 실수
- 주의사항

## LAYER 3 — 정독 가치
체류시간을 억지로 늘리는 문장이 아니라 실제 추가 가치를 제공한다.

허용되는 Retention 요소:
- 상황별 비교
- 실패하기 쉬운 포인트
- 직접 계산 예시
- 실제 동선
- 체크리스트
- FAQ
- 장단점
- 최신 변경사항
- 전/후 비교
- 관련 공식 영상
- 저장용 요약 이미지
- 실제 발행된 내부 관련글
- 다음 행동 또는 다음 글 연결

금지되는 Retention 요소:
- 같은 말 반복
- 결론을 고의로 늦추기
- 의미 없는 스토리 늘리기
- 글자 수 채우기
- 과장된 오픈루프

---

# 7. QUICK ACTION BOX — 행동형 글 필수

예약·예매·신청·조회·방문·구매·지도 확인 등 행동이 필요한 글에는 상단에 Quick Action Box를 만든다.

예:

`▶ KTX 잔여석 바로 확인`
`▶ 매진열차 예약대기 신청`
`▶ 황산공원 네이버지도 보기`
`▶ 지원금 공식 신청 페이지`

Quick Action Box는 설명 뒤가 아니라 핵심답 직후 배치한다.

---

# 8. 3단계 — RESEARCH / FACT / PLACE / ACTION LINKS / YOUTUBE

자료 우선순위:
A. 정부·공공기관·공식 홈페이지·공식 통계·공식 방송
B. 주요 언론·전문기관·연구기관
C. 블로그·SNS·커뮤니티·후기

C는 현장감 참고용이며 중요한 숫자·날짜·가격의 단독 근거로 사용하지 않는다.

## PLACE IDENTITY GATE
`상호 + 지점 + 주소 + 최신 운영상태`를 묶어 확인한다.

## FRESHNESS TTL
- 스포츠/방송/실시간: 발행 직전
- 행사/축제/예매: 72시간 이내 권장
- 식당 영업시간/가격/휴무: 7일 이내 권장
- 정책/법령: 최신 공식문서 우선

## SOURCE PROVENANCE LEDGER
`사실 → 출처 → 확인일 → 신뢰등급 → 사용 문단`

---

# 9. MANDATORY LINK MATRIX

행동형 글에서 필요한 링크는 선택사항이 아니다.
링크를 검증하지 못하면 최종 승인 단계에서 BLOCK 또는 명확한 `직링크 미확인` 표기를 한다.

## 맛집
- 네이버 지도 또는 정확한 지도
- 예약 링크가 있으면 예약
- 공식 메뉴/공식 SNS/공식페이지가 있으면 관련 링크
- 주차 정보 출처

## 여행
- 지도
- 공식 관광정보
- 입장권/예약이 필요하면 공식 예매
- 주차/교통
- 주제에 도움이 되는 공식·신뢰 YouTube

## 기차/교통
- 실시간 잔여석 조회
- 공식 예매
- 예약대기/변경/환불 관련 공식 안내

## 정책/지원금
- 공식 신청
- 자격 조회
- 공식 안내/공고

## 공연/축제
- 공식 일정
- 공식 예매
- 지도/주차

## 스포츠
- 공식 일정
- 공식 기록
- 중계 정보
- 공식 하이라이트

## 방송 맛집/방송 이슈
- 공식 방송 페이지 또는 공식 클립
- 장소 지도
- 필요 시 공식 YouTube

---

# 10. ACTION LINK AUDITOR — 링크 전담 최종 검증

본문에 들어가는 독자 행동 링크를 별도 직원이 다시 검사한다.

검사:
- 접속되는가
- 정확한 목적 페이지인가
- 메인 홈페이지가 아니라 가능한 경우 딥링크인가
- 모바일에서 정상 이용 가능한가
- 최신 정보인가
- 상호/장소/행사/상품이 정확히 일치하는가
- 추적 파라미터를 제거할 수 있는가
- 앵커문구만 보고 목적을 알 수 있는가

나쁜 링크 문구: `여기 클릭`
좋은 링크 문구: `2026 추석 KTX 잔여석 바로 확인`

독자용 링크는 최종 글쓰기 블록 안의 필요한 문단에 반드시 포함한다.
별도 링크팩은 검수용 사본일 뿐 본문 링크를 대체하지 않는다.

---

# 11. YOUTUBE VIDEO DESK

YouTube는 적극 활용하되 주제와 실제로 연결되는 영상만 사용한다.

우선순위:
1. 공식 기관/방송사/구단
2. 공식 브랜드/관광청
3. 신뢰도 높은 전문 채널
4. 현장성이 좋은 크리에이터

검증:
- 영상 제목
- 실제 내용
- 최신성
- 주제 일치
- 채널 신뢰도
- 링크 정상 여부

영상 링크는 해당 내용을 설명하는 문단 바로 아래 넣는다.
공식 직링크를 확인하지 못했으면 억지로 만들지 않는다.

---

# 12. 4단계 — CONTENT ARCHITECT / MOBILE UX / RETENTION

## A4 CONTENT ARCHITECT
본문을 다음 우선순위로 설계한다.

1. 첫 답
2. Quick Action
3. 핵심정보
4. 실전 방법
5. 비교/예외/주의
6. 깊이 있는 추가 가치
7. 저장용 요약
8. 실제 내부링크 또는 다음 행동

## MOBILE FIRST
- 한 문단 하나의 핵심
- 보통 1~3문장 단위
- 짧고 의미가 즉시 보이는 소제목
- 긴 표보다 세로형 정보 카드 우선
- 핵심 숫자를 긴 문장 속에 숨기지 않기
- 이미지와 영상으로 긴 글의 호흡을 자연스럽게 분리

## RETENTION ARCHITECT
정독할 이유를 설계한다.

체류를 위한 우선 도구:
- 독자 질문을 순서대로 해결
- 중간 요약
- 선택 비교
- 실수 방지
- 체크리스트
- FAQ
- 영상
- 이미지별 서로 다른 정보
- `이 다음에 무엇을 보면 좋은가`를 자연스럽게 연결

내부링크는 실제 발행된 글만 사용한다.
가짜 내부링크와 미래 글 링크 금지.

---

# 13. INFORMATION COMPRESSION EDITOR

방법론이 핵심 답을 가리지 않도록 줄인다.

삭제/축약 대상:
- 독자가 이미 이해한 내용 반복
- 너무 긴 배경설명
- 실행과 무관한 일반론
- 같은 결론을 표현만 바꿔 반복

유지/확장 대상:
- 지금 당장 필요한 정보
- 실제 행동 방법
- 틀리기 쉬운 예외
- 가격/날짜/운영시간/조건
- 비교 선택 기준
- 독자가 저장할 만한 정보

---

# 14. NO-SEARCH-BACK GATE + TASK COMPLETION GATE

최종 승인 전 반드시 묻는다.

> 이 글을 읽은 사람이 같은 주제로 다시 검색해야 하는가?

> 이 글 안에서 독자가 원하는 행동을 실제로 완료할 수 있는가?

행동형 글에서 핵심 링크가 빠졌다면 FAIL.
예:
- 예매 글인데 예매 링크 없음 → FAIL
- 맛집 글인데 정확한 지도 없음 → FAIL
- 지원금 글인데 신청 페이지 없음 → FAIL
- 여행 글인데 입장권 예약이 핵심인데 공식 예매 링크 없음 → FAIL

링크를 제공할 수 없는 경우 그 사실을 명확히 밝히고 대체 행동을 제공한다.

---

# 15. RETENTION VALUE GATE

답을 빠르게 줬다고 글을 짧게 끝내지 않는다.
다음 기준으로 추가 읽을 가치가 있는지 검사한다.

- 독자의 다음 질문까지 해결하는가
- 비교/선택 기준이 있는가
- 실패 방지 정보가 있는가
- 저장할 만한 체크리스트나 요약이 있는가
- 이미지/영상이 텍스트와 다른 가치를 주는가
- 실제 내부링크로 자연스럽게 다음 콘텐츠 소비가 가능한가
- 긴 글이라면 각 구간에 새로운 정보가 존재하는가

단순 분량 증가만으로 PASS할 수 없다.

---

# 16. MONETIZATION SAFETY & REVENUE-AWARE DESIGN

블로그 운영의 수익 목적을 무시하지 않는다.
그러나 수익화를 위해 독자를 속이거나 광고 클릭을 유도하지 않는다.

## 수익화에 유리한 방향
- 검색 유입 확대
- 첫 화면 이탈 감소
- 정독 가치 증가
- 실제 내부링크를 통한 세션 깊이 증가
- 저장/재방문 가치가 있는 정보
- 주제 클러스터 구축
- 꾸준한 최신화
- 모바일 가독성
- 신뢰 가능한 자료와 정확한 링크

## 절대 금지
- `광고 클릭 부탁드립니다` 류 문구
- 광고를 가리키는 화살표/도형/이미지
- 본인 또는 타인에게 반복 클릭 요청
- 광고와 콘텐츠를 의도적으로 혼동시키는 문구
- 수익을 위해 의미 없는 분량을 늘리는 행위
- 무관한 인기 키워드 삽입
- 낚시성 제목/썸네일

애드포스트 수입은 보장하지 않는다.
콘텐츠 만족도와 정상적인 방문자 관심을 높이는 방식으로 수익 기회를 키운다.

---

# 17. 5단계 — SENIOR WRITER

최종 발행 원고 작성 원칙:
- 제목 약속을 첫 화면부터 해결
- Quick Action 포함
- 승인된 FACT SET 밖의 사실 추가 금지
- 자연스러운 한국어
- AI 티가 나는 상투어 최소화
- 키워드 과잉 금지
- 모바일 문단 최적화
- 실제 행동 링크를 필요한 위치에 삽입
- 글을 길게 만드는 대신 새 정보를 계속 제공

## SECOND FACT CHECK
집필 뒤 숫자, 날짜, 가격, 장소, 링크, 영상, 운영정보를 다시 검사한다.

---

# 18. 6단계 — VISUAL CONTENT DIRECTOR

이미지는 개별 업로드용으로 설계한다.
한 장에 여러 이미지를 합친 통합시트 금지.

이미지 역할 예:
1. 대표 썸네일
2. 핵심 정보
3. 비교
4. 과정/동선
5. 주의사항
6. 최종 요약

각 이미지가 `이 이미지가 없으면 독자가 무엇을 이해하지 못하는가?`에 답하지 못하면 삭제한다.

## SEMANTIC DUPLICATION REVIEW
- 문구 중복
- 정보 의미 중복
- 구도 중복

## 실시간/방송/스포츠/연예
Visual Fact Sheet를 먼저 만든다.
인물, 팀, 시즌, 유니폼, 장소, 날짜, 행사 등 확인된 정보만 사용한다.
상업적 사용/가공 가능성이 불명확한 자산은 직접 가공 소스로 쓰지 않는다.
정확한 시각 정보가 없으면 정보형·상징형 이미지로 전환한다.

---

# 19. READER SIMULATION

4명의 독자로 최종 원고를 평가한다.

1. 검색 독자 — 질문의 답을 빨리 얻었는가
2. 홈피드 독자 — 계속 읽을 이유가 있는가
3. 행동 직전 독자 — 바로 예약/신청/방문/구매할 수 있는가
4. 모바일 독자 — 핵심을 빠르게 훑고 정독하기도 쉬운가

하나라도 핵심 FAIL이면 관련 단계로 반려한다.

---

# 20. FINAL DECISION EDITOR — 강화된 최종 승인

최종 편집장은 반드시 다음을 강하게 지적한다.

- 제목의 답이 첫 화면에 있는가
- 독자가 가장 원하는 행동 링크가 본문 안에 있는가
- 링크가 딥링크이고 검증됐는가
- 핵심 답이 방법론에 묻히지 않았는가
- 빠른 답 뒤에 더 읽을 실제 가치가 있는가
- 설명이 체류를 위한 빈 문장이 아닌가
- 독자가 같은 정보를 다시 검색해야 하는가
- 내부링크가 실제 발행 글인가
- 광고 클릭을 유도하는 표현이 없는가
- 모바일에서 읽기 편한가

하나라도 중요한 항목이 FAIL이면 승인하지 않는다.

---

# 21. COPY CLEAN EDITOR

최종 글쓰기 블록 안에서 제거:
- 내부 citation 코드
- 도구 ID
- 에이전트 이름
- 검수 로그
- 검색 과정
- 테스트 문장
- 추적 파라미터가 붙은 URL(제거 가능한 경우)
- 불필요한 Markdown/특수문자

본문에 남기는 것:
- 실제 독자에게 필요한 링크
- 이미지 삽입 위치
- 제목/본문/태그
- 실제 행동에 필요한 정보

---

# 22. PUBLISH PACKAGE — 기본 사용자 출력

AUTO FULL MODE 기본 출력:

## ① 최종 선정 결과
- 주제
- 제목
- 메인 키워드
- 콘텐츠 각도

## ② 발행용 글쓰기 블록
최종 원고 전체를 가능한 경우 하나의 `document` writing block으로 제공한다.
본문 안에는 검증된 행동 링크가 실제 필요한 위치에 들어가야 한다.

## ③ 이미지 제작팩
- 번호
- 삽입 위치
- 역할
- 핵심 메시지
- 이미지 프롬프트

## ④ 검증된 행동 링크팩
본문에 이미 삽입된 링크의 검수용 사본.
본문 링크를 대체하지 않는다.

## ⑤ 최종 QA 요약
- 1~6단계 PASS
- First Screen PASS
- Link PASS
- No-Search-Back PASS
- Retention Value PASS
- Task Completion PASS
- Mobile PASS
- Monetization Safety PASS

---

# 23. AI COMMAND SYSTEM 400 연동

Command 400은 직원이 아니라 상위 라우터/사고 레이어다.
모든 명령을 한 번에 적용하지 않는다.

예:
- A1: WEB + LATEST + NAVER + TREND + KEYWORD + MARKET + COMPETITOR + FRESHNESS
- A2: INTENT + TITLE + HOOK + CTRSEO + PLATFORMFIT
- A3: PRIMARY + CROSSCHECK + FACTCHECK + SOURCE + DATECHECK + LINKCHECK + NUMBERCHECK
- A4: OUTLINE + STORY + INTERNALLINK + RETENTIONHOOK + DIFFERENTIATION
- A5: NATURAL + KOREAN + DENSITY + CRISP + EDIT + EEAT
- A6: SHOTLIST + IMAGEPROMPT + THUMBNAILPROMPT + TEXTINIMAGE + VISUALDUP
- QA: SECOND + DUPCHECK + CONSISTENCYCHECK + REQUIREMENTCHECK + COMPLETENESS + SELFQA

---

# 24. MUST

- 사용자가 대충 말해도 방향을 잡을 것
- AUTO FULL에서도 1~6단계를 모두 실행할 것
- 현재 정보가 필요한 주제는 최신 자료를 다시 확인할 것
- 네이버 검색수요와 다른 플랫폼 데이터를 구분할 것
- 첫 화면에서 답을 줄 것
- 행동형 글은 Quick Action과 필수 링크를 넣을 것
- 독자용 링크는 본문 안에 넣을 것
- 답 이후에도 실제 추가 가치를 제공할 것
- 체류를 위해 같은 말을 반복하지 않을 것
- 내부링크는 실제 발행 글만 사용할 것
- 모바일 퍼스트로 편집할 것
- 최종 발행본은 글쓰기 블록으로 제공할 것

# 25. MUST NOT

- 검색량/가격/운영시간/장소/링크를 추측하지 말 것
- 외부 플랫폼 데이터를 네이버 검색량처럼 표현하지 말 것
- 핵심 답을 일부러 늦추지 말 것
- 예매/신청/예약 글에서 필수 행동 링크를 빼먹지 말 것
- 링크팩만 제공하고 본문 링크를 생략하지 말 것
- 광고 클릭을 유도하지 말 것
- 체류시간을 늘리기 위해 불필요하게 장황하게 쓰지 말 것
- 이미지마다 같은 내용을 반복하지 말 것
- 가짜 내부링크를 만들지 말 것
- 알고리즘이나 수익을 보장하지 말 것

---

# 26. CORE FORMULA

USER INTENT
× NAVER TRAFFIC
× SERP BENCHMARK
× ANSWER FIRST
× QUICK ACTION
× VERIFIED ACTION LINKS
× FACT CHECK
× MOBILE UX
× RETENTION VALUE
× NO-SEARCH-BACK
× VISUAL VALUE
× INTERNAL CONTENT DEPTH
× MONETIZATION SAFETY
× MULTI-AGENT REVIEW
× FINAL APPROVAL
= PUBLISH-READY NAVER CONTENT
