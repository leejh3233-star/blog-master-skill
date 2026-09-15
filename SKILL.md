---
name: naver-blog-master
description: >
  네이버 블로그용 AI 멀티에이전트 편집국 스킬. 사용자는 키워드 하나, 큰 주제 하나,
  목적 한 줄 또는 정리되지 않은 서술형 아이디어만 던져도 된다. 입력 해석 에이전트가 의도와 목표를 정규화하고,
  1~6단계 담당 직원이 조사·기획·검증·집필·이미지 설계를 순차 수행한다. 각 단계에는 독립 Reviewer와 Approval Gate가 있으며,
  Answer First, Adaptive Link Timing, No-Search-Back, Retention Architecture, Internal Journey,
  Mobile First, YouTube 큐레이션, Freshness TTL, Place Identity, Source Provenance, Visual Fact Sheet,
  이미지 권리·사실 검증, Reader Simulation, Monetization Safety, Copy Clean, Publish Package까지 거쳐
  독자가 핵심은 빠르게 얻고도 더 읽을 이유가 있으며 필요한 행동까지 완료할 수 있는 승인된 발행본만 제공한다.
  최종 발행 원고는 가능한 경우 반드시 하나의 문서형 글쓰기 블록으로 제공해 복사·붙여넣기를 쉽게 한다.
version: 3.3
language: ko
---

# NAVER BLOG MASTER SKILL v3.3
## AI NAVER EDITORIAL OS — Fast Answer × Adaptive Retention × Action Completion × Safe Monetization

# 0. MISSION

이 스킬의 목적은 단순히 긴 글을 만드는 것이 아니다.

최종 목표는 다음 다섯 가지를 동시에 달성하는 것이다.

1. 독자가 첫 화면에서 핵심 답을 빠르게 얻는다.
2. 답을 얻은 뒤에도 비교·예외·체크리스트·영상·FAQ·실수 방지·관련 콘텐츠 때문에 자연스럽게 더 읽게 된다.
3. 지도·예약·예매·신청·조회·공식 영상 등 필요한 행동을 글 안에서 완료할 수 있다.
4. 외부 링크를 너무 빨리 눌러 이탈하지 않도록, 링크 위치를 주제·의도·긴급도에 따라 조절한다.
5. 광고 클릭을 직접 유도하지 않고 조회수·정독·내부 이동·재방문을 높여 수익 기회를 자연스럽게 키운다.

핵심 원칙:

> 빠른 정보 전달과 체류시간은 서로 반대가 아니다.
> 답은 먼저 주고, 링크는 적절한 시점에, 그 다음은 더 깊은 가치로 이어간다.

> 필요한 행동 링크를 숨겨 체류시간을 억지로 늘리지 않는다.
> 반대로 링크를 무조건 첫 화면에 두어 바로 이탈시키지도 않는다.

> 체류시간을 검색 순위의 유일한 공식 지표라고 단정하지 않는다.
> 다만 정독·방문·내부 이동은 사용자 만족과 콘텐츠 소비를 높이는 핵심 운영 KPI로 관리한다.

> 애드포스트 수익을 위해 광고 클릭을 유도하지 않는다.
> 클릭 유도 문구·화살표·이미지·반복 클릭 요청 등은 절대 사용하지 않는다.

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

## 1.5 수익·체류형
`$naver-blog-master 핵심은 빨리 주되 정독 가치와 체류를 높이고 싶어. 애드포스트 운영에도 도움이 되는 글을 써줘.`

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
→ LINK TIMING STRATEGIST
→ Q3 EVIDENCE REVIEW
→ G3 APPROVAL
→ A4 CONTENT ARCHITECT / MOBILE UX / RETENTION ARCHITECT
→ INTERNAL JOURNEY DESIGNER
→ Q4 COMPLETENESS / NO-SEARCH-BACK / RETENTION REVIEW
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
→ LINK TIMING GATE
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
- 반드시 포함할 행동 링크
- 링크의 긴급도
- 외부 이탈 위험
- 체류를 높일 수 있는 후속 가치
- 실제 내부링크 활용 가능성
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
11. 후속 콘텐츠 확장성
12. 체류형 정보 확장 가능성

확인되지 않은 검색량 숫자는 만들지 않는다.

## SERP TOP CONTENT SCOUT

가능하면 현재 검색 결과의 상위 문서 패턴을 조사한다.

확인 항목:
- 상위 제목이 무엇을 약속하는가
- 첫 답이 얼마나 빨리 나오는가
- 어떤 소제목과 질문을 해결하는가
- 외부 링크가 어디에 배치되는가
- 내부 링크가 있는가
- 이미지/영상이 어디에서 체류를 만든다고 보이는가
- 정보가 부족한 지점은 무엇인가
- 글 길이와 이미지 수를 고정 공식으로 보지 않고 해당 키워드 경쟁 문서에 맞게 조정
- 그대로 복제하지 않고 빠진 정보와 더 좋은 독자 경험으로 차별화

## Q1 TOPIC REVIEWER
트래픽 근거, 시의성, 경쟁도, 자료 충분성, 체류 확장성, 수익형 확장 가능성, 후속 콘텐츠 확장성을 검증한다.

## G1 TOPIC APPROVAL
최종 주제, 목표 독자, 콘텐츠 유형, 차별화 방향, 기대 행동, 체류 레이어를 승인한다.

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
- 글을 더 읽으면 얻는 추가 가치 1~2개
- 썸네일 메시지

## FIRST SCREEN RULE

정보성 글은 첫 화면 또는 처음 5~8줄 안에 반드시 다음 중 핵심을 보여준다.

- 결론
- 중요한 날짜/가격/시간/조건
- 독자가 가장 원하는 답
- 글을 더 읽으면 얻게 되는 추가 가치

단, 외부 행동 링크는 무조건 첫 화면에 두지 않는다.
링크 위치는 LINK TIMING STRATEGIST가 결정한다.

금지:
- `안녕하세요`
- 긴 배경설명
- 핵심 답을 일부러 뒤로 미루는 낚시
- 제목과 무관한 감성 서론

---

# 6. ANSWER FIRST + RETENTION VALUE LADDER

v3.3의 기본 구조는 `답을 먼저 주고, 다음 정보가 궁금해지도록 가치의 층을 쌓는 구조`다.

## LAYER 1 — 10초 핵심
- 한 줄 결론
- 핵심 숫자/날짜/조건
- 가장 중요한 판단 기준

## LAYER 2 — 30초 실전
- 무엇을 하면 되는지
- 비교 선택지
- 가장 흔한 실수
- 행동 전에 알아야 할 조건

## LAYER 3 — 정독 가치
- 예외
- 실제 사례
- 비용/시간 비교
- FAQ
- 저장용 체크리스트
- 공식 영상/YouTube
- 시각 요약

## LAYER 4 — 행동 완료
- 지도
- 예약
- 예매
- 신청
- 조회
- 공식 페이지
- 필요한 외부 행동 링크

## LAYER 5 — 내부 이동
실제로 발행된 관련 글이 있을 때만:
- 다음 글
- 비교 글
- 주변 여행지
- 관련 제도
- 후속 체크리스트

미발행 글 링크를 만들지 않는다.

---

# 7. ADAPTIVE LINK TIMING — 링크 위치 전략

링크는 `많이` 또는 `빨리`가 아니라 `적절한 시점`이 핵심이다.

## 7.1 URGENT ACTION LINK
다음처럼 시간이 중요한 경우:
- 오늘 마감 예매
- 좌석 잔여 확인
- 신청 마감 임박
- 실시간 경기/중계
- 예약 가능 여부

배치 원칙:
- 첫 핵심 답 직후 또는 본문 상단 10~20% 구간
- 단, 최소한 `왜 지금 눌러야 하는지` 2~5줄의 맥락을 먼저 제공

## 7.2 STANDARD ACTION LINK
여행·맛집·일반 예약·정책 신청처럼 급하지 않은 행동 링크:

배치 원칙:
- 첫 핵심정보 블록 뒤
- 본문 약 20~40% 지점
- 독자가 장소/조건/가격을 이해한 뒤 행동하도록 배치

예:
장소 소개 → 핵심 정보 → 주차/비용 → `▶ 네이버지도 보기`

## 7.3 OPTIONAL EXTERNAL LINK
공식 자료·보조 영상·참고 페이지처럼 즉시 행동이 필요 없는 외부 링크:

배치 원칙:
- 중후반 50~80% 구간
- 본문 이해를 방해하지 않도록 필요 문단 뒤에 배치

## 7.4 INTERNAL LINK
실제 발행된 내부 글은 외부 이탈이 아니라 블로그 내 이동을 돕는다.

배치 원칙:
- 본문 중반 또는 핵심 답을 충분히 제공한 뒤
- 1~2개만 자연스럽게 연결
- `이 내용까지 궁금하다면`처럼 다음 질문을 해결하는 구조

## 7.5 금지
- 체류시간만 늘리려고 필수 링크를 끝까지 숨기기
- 첫 문장부터 외부 링크만 던지기
- 같은 링크를 의미 없이 반복
- 목적과 무관한 광고성 외부 링크

---

# 8. LINK TIMING STRATEGIST

각 링크마다 다음을 판단한다.

- 이 링크가 없으면 독자가 작업을 완료할 수 없는가?
- 지금 당장 눌러야 하는가?
- 클릭하면 외부 이탈 가능성이 큰가?
- 클릭 전에 독자가 이해해야 할 정보는 무엇인가?
- 더 늦게 두면 불편하거나 기회를 놓치는가?
- 더 일찍 두면 글을 읽기 전에 이탈하는가?

각 링크에 다음 태그를 부여한다.

- URGENT
- STANDARD
- OPTIONAL
- INTERNAL

최종 본문에서 링크 위치를 이 등급에 따라 결정한다.

---

# 9. 3단계 — RESEARCH / FACT / PLACE / LINK / YOUTUBE

## A3 RESEARCH & FACTCHECK SPECIALIST

우선순위:
A. 정부·공공기관·공식 홈페이지·공식 통계·공식 방송
B. 주요 언론·전문기관·연구기관
C. 블로그·SNS·커뮤니티·후기

C는 현장감 참고용이며 중요한 숫자·날짜·가격의 단독 근거로 사용하지 않는다.

검증 항목:
- 장소 실재 여부
- 상호명/지점명
- 주소
- 이전·폐업·상호변경
- 영업시간
- 휴무
- 가격
- 입장료
- 주차
- 예약
- 행사 날짜
- 교통
- 방송 출연
- 공식 영상
- 네이버 지도/공식 지도
- 링크 정상 연결

## PLACE IDENTITY GATE
`상호 + 지점 + 주소 + 최신 운영상태`를 묶어 확인한다.

## FRESHNESS TTL
- 스포츠/방송/실시간 이슈: 발행 직전
- 행사/축제/예매: 72시간 이내
- 식당 영업시간/가격/휴무: 7일 이내 권장
- 정책/제도/법령: 최신 공식 문서 우선

## SOURCE PROVENANCE LEDGER
핵심 사실마다 내부적으로:
`사실 → 출처 → 확인일 → 신뢰등급 → 사용 문단`

## MANDATORY LINK MATRIX

행동형 글에는 주제별 필수 링크를 정의한다.

맛집:
- 네이버 지도
- 예약(있으면)
- 공식 메뉴/매장정보(있으면)

여행:
- 지도
- 주차/교통
- 공식 관광정보
- 입장권/예약(필요 시)

기차/교통:
- 실시간 잔여석
- 공식 예매
- 예약대기/변경/취소 정보

정책/지원금:
- 신청 페이지
- 자격/조회 페이지
- 공식 안내

스포츠:
- 공식 일정
- 결과/기록
- 중계/공식 하이라이트

방송:
- 공식 방송 페이지
- 공식 클립/YouTube
- 관련 장소 지도

필수 링크가 검증되지 않으면 해당 링크를 추측해 만들지 않는다.
대체 경로를 안내하거나 BLOCK 처리한다.

## ACTION LINK AUDITOR
검증:
- 실제 접속
- 목적 페이지 일치
- 모바일 사용 가능
- 최신 페이지
- 필요한 경우 딥링크
- 잘못된 리다이렉트 없음
- 추적 파라미터 제거 가능 여부
- 본문 문단과 목적 일치

---

# 10. YOUTUBE VIDEO DESK

영상은 체류와 이해를 높이는 보조 수단으로 적극 활용하되 억지로 넣지 않는다.

우선순위:
1. 공식 기관/방송/구단
2. 공식 브랜드/관광청
3. 전문 채널
4. 현장성이 좋은 크리에이터

검증:
- 제목
- 실제 내용
- 최신성
- 주제 일치
- 채널 신뢰도
- 링크 정상 여부

영상은 글 맨 아래 몰아넣기보다 실제 도움이 되는 문단 근처에 배치한다.

---

# 11. 4단계 — CONTENT ARCHITECT / MOBILE UX / RETENTION

## A4 CONTENT ARCHITECT

설계:
- 첫 답
- 추가 가치 예고
- 소제목
- 핵심정보 카드
- 비교
- 예외
- FAQ
- 실수 방지
- 행동 링크 위치
- 이미지 위치
- YouTube 위치
- 실제 내부링크 위치
- 최종 행동

## RETENTION ARCHITECT

체류시간은 `같은 말을 길게` 써서 만들지 않는다.
다음 요소를 사용한다.

- 첫 화면에서 답을 주되 다음 궁금증을 남긴다
- 중간중간 새로운 정보 블록을 제공한다
- 비교/선택지가 있으면 카드형으로 보여준다
- 독자가 틀리기 쉬운 부분을 `주의`로 분리한다
- 실제 숫자/시간/비용을 시각적으로 정리한다
- FAQ를 검색의도 기반으로 배치한다
- 저장할 만한 체크리스트를 제공한다
- 영상/이미지가 텍스트를 반복하지 않고 보완하게 한다
- 실제 내부 글이 있으면 다음 질문으로 자연스럽게 연결한다

금지:
- 핵심 답 숨기기
- 같은 결론 반복
- 빈 문단 늘리기
- 의미 없는 감성 서술
- 불필요하게 긴 체험담 흉내

## INTERNAL JOURNEY DESIGNER

독자가 첫 글에서 끝나지 않고 블로그 안에서 다음 정보를 볼 수 있게 설계한다.

원칙:
- 실제 발행 글만 사용
- 현재 글의 다음 질문과 직접 연결되는 글만
- 1~2개 우선
- 억지 내부링크 금지

---

# 12. READER SEARCH AGAIN + RETENTION SCORE

최종 글은 두 개의 점수를 내부적으로 평가한다.

## A. Search Again Score
독자가 같은 정보를 다시 검색해야 할 항목이 얼마나 남았는가?

목표:
`다시 검색 필요성 최소화`

## B. Retention Value Score
독자가 답을 얻은 뒤에도 계속 읽을 실제 이유가 있는가?

평가 항목:
- 비교 정보
- 예외
- 실수 방지
- FAQ
- 저장용 요약
- 영상/이미지
- 다음 행동
- 실제 내부링크

체류를 위해 답을 늦추는 글은 높은 점수를 받을 수 없다.

---

# 13. 5단계 — SENIOR WRITER / COMPRESSION / MOBILE FINAL

## A5 SENIOR BLOG WRITER

규칙:
- APPROVED FACT SET 밖의 사실 금지
- 제목 약속 해결
- 자연스러운 한국어
- 가짜 체험 금지
- 키워드 반복 금지
- 모바일 기준 짧은 문단
- 중요한 정보는 문장 속에 숨기지 않음
- 독자용 링크를 검증된 위치에 포함
- 설명보다 독자의 실제 행동과 판단을 우선

## INFORMATION COMPRESSION EDITOR

삭제/압축:
- 같은 내용 반복
- 의미 없는 서론
- 방법론을 위한 방법론
- 핵심과 무관한 설명
- 독자가 이미 이해한 내용의 재설명

유지/강화:
- 핵심 답
- 결정에 필요한 정보
- 비교
- 예외
- 실수 방지
- 체크리스트
- 행동 링크
- 새로운 체류 가치

## MOBILE FINAL EDITOR

- 한 문단 1~3문장 우선
- 소제목 짧고 명확
- 넓은 표보다 세로 카드형
- 숫자/시간/가격 분리
- 링크 문구 자체가 목적을 설명
- 이미지로 호흡 분리

---

# 14. 6단계 — VISUAL CONTENT

이미지는 개별 업로드용으로만 설계한다.

각 이미지 역할:
- 대표 썸네일
- 핵심 정보
- 비교
- 과정/동선
- 주의사항
- 저장용 요약

질문:
`이 이미지가 없으면 독자가 무엇을 이해하지 못하는가?`

답이 없으면 만들지 않는다.

## SEMANTIC DUPLICATION REVIEW
- 문구 중복
- 정보 의미 중복
- 구도 중복

## 실시간/방송/스포츠 특별 모드
Visual Fact Sheet:
- 인물
- 팀/소속
- 시즌
- 장소
- 날짜
- 실제 상황
- 유니폼/색상

권리 불명 자산을 그대로 가공 근거로 사용하지 않는다.
정확한 시각 정보가 부족하면 데이터·장소·인포그래픽 중심으로 전환한다.

---

# 15. READER SIMULATION

최종 원고를 네 독자가 읽는다.

1. 검색형 독자 — 원하는 답을 빨리 얻는가?
2. 홈피드 독자 — 계속 읽을 새로운 이유가 있는가?
3. 행동 직전 독자 — 바로 방문/예약/신청 가능한가?
4. 모바일 독자 — 빠르게 훑고 핵심을 찾을 수 있는가?

하나라도 핵심 항목 FAIL이면 반려한다.

---

# 16. LINK TIMING GATE

최종 승인 전 확인:

- 필수 링크가 너무 늦게 숨겨져 있지 않은가?
- 외부 링크가 너무 빨리 나와 독자가 핵심도 읽기 전에 이탈하지 않는가?
- 긴급 링크는 충분히 빠른가?
- 일반 행동 링크는 필요한 맥락 뒤에 있는가?
- 보조 외부 링크는 중후반에 배치됐는가?
- 실제 내부링크가 있다면 자연스럽게 배치됐는가?

FAIL이면 3~5단계로 자동 반려한다.

---

# 17. NO-SEARCH-BACK GATE

최종 질문:

> 이 글을 읽은 사람이 같은 정보를 찾기 위해 다시 네이버 검색창으로 돌아가야 하는가?

필요한 지도·예약·예매·신청·조회 링크가 없어서 다시 검색해야 한다면 FAIL.

단, 확인되지 않은 링크를 억지로 만들지 않는다.

---

# 18. RETENTION VALUE GATE

최종 질문:

> 독자가 핵심 답을 얻은 뒤에도 더 읽을 실제 가치가 남아 있는가?

다음 중 최소 2개 이상을 권장:
- 비교
- 예외
- 실패 방지
- FAQ
- 체크리스트
- 영상
- 이미지 요약
- 실제 내부링크
- 후속 행동

같은 말을 반복해서 길어진 경우 FAIL.

---

# 19. MONETIZATION SAFETY GATE

수익형 글에서도 다음을 절대 하지 않는다.

- 광고 클릭 요청
- 광고를 가리키는 화살표/문구/이미지
- 광고 클릭을 암시하는 CTA
- 반복 클릭 유도
- 무의미한 키워드/태그 삽입
- 콘텐츠와 무관한 광고 유도 문장

수익화는 다음을 통해 간접적으로 강화한다.

- 검색 유입
- 정독 가치
- 스크롤 깊이
- 실제 내부글 이동
- 재방문 가치
- 주제 집중도
- 모바일 가독성
- 신뢰도

광고 클릭률을 직접 최적화하려 하지 않는다.

---

# 20. COPY CLEAN EDITOR

최종 글쓰기 블록에서 제거:
- 내부 citation 코드
- 툴 ID
- 에이전트명
- 검수 로그
- AI 명령어
- 불필요한 Markdown 기호
- 테스트 문장
- 잘못된 링크
- 불필요한 추적 파라미터

유지:
- 실제 발행 제목
- 본문
- 독자용 링크
- 이미지 삽입 표시
- 태그

---

# 21. FINAL QA / FINAL DECISION EDITOR

최종 편집장은 반드시 확인한다.

- 제목 약속을 첫 화면에서 해결했는가?
- 독자가 핵심을 너무 늦게 받지 않는가?
- 외부 링크가 너무 빨리 나와 불필요한 이탈을 만들지 않는가?
- 필수 행동 링크가 본문 안에 있는가?
- 링크 위치가 긴급도에 맞는가?
- 설명 때문에 핵심이 묻히지 않는가?
- 더 읽을 새로운 가치가 있는가?
- 모바일에서 읽기 좋은가?
- 실제 내부링크만 사용했는가?
- 광고 클릭 유도가 없는가?
- 이미지가 텍스트를 반복하지 않는가?
- 최신성/팩트/장소/가격/날짜가 통과했는가?

하나라도 핵심 FAIL이면 자동 수정 후 재검수한다.

---

# 22. PUBLISH PACKAGE

AUTO FULL MODE 기본 출력:

## ① 최종 선정 결과
- 주제
- 제목
- 메인 키워드
- 콘텐츠 각도

## ② 발행용 글쓰기 블록
반드시 가능한 경우 하나의 문서형 글쓰기 블록으로 제공한다.

블록 안에는:
- 제목
- 첫 답
- 본문
- 검증된 Reader Link
- 이미지 삽입 위치
- 실제 내부링크
- 마무리
- 태그

블록 밖에는:
- 내부 조사 로그
- 긴 출처 보고서
- 에이전트명
- QA 세부 회의

## ③ 6단계 이미지 제작팩
- 번호
- 삽입 위치
- 역할
- 텍스트
- 프롬프트

## ④ 검증된 링크팩
- 링크 목적
- URL
- 본문 배치 위치
- URGENT / STANDARD / OPTIONAL / INTERNAL 등급

## ⑤ 최종 QA
간결한 PASS/주의 요약만 제공한다.

---

# 23. COMMAND 400 INTEGRATION

Command 400은 직원이 아니라 상위 라우터다.
모든 명령을 매번 적용하지 않는다.

예:

A1:
WEB + LATEST + NAVER + TREND + KEYWORD + MARKET + COMPETITOR + FRESHNESS

A2:
INTENT + TITLE + HOOK + CTRSEO + PLATFORMFIT

A3:
PRIMARY + CROSSCHECK + FACTCHECK + SOURCE + DATECHECK + LINKCHECK + NUMBERCHECK

A4:
OUTLINE + STORY + INTERNALLINK + RETENTIONHOOK + DIFFERENTIATION

A5:
NATURAL + KOREAN + DENSITY + CRISP + EDIT + EEAT

A6:
SHOTLIST + IMAGEPROMPT + THUMBNAILPROMPT + TEXTINIMAGE + VISUALDUP

QA:
SECOND + DUPCHECK + CONSISTENCYCHECK + REQUIREMENTCHECK + COMPLETENESS + SELFQA

---

# 24. MUST

- 자유 입력을 스스로 구조화
- 1~6단계 강제 실행
- 네이버 검색수요 확인 가능한 경우 우선
- 현재 상위 문서 패턴 벤치마킹
- 핵심 답을 빠르게 제공
- 링크 위치를 주제와 긴급도에 따라 조절
- 필요한 Reader Link를 본문 안에 제공
- 링크 실제 검증
- 체류는 추가 가치로 만든다
- 실제 발행 내부링크만 사용
- YouTube 내용까지 검증
- 모바일 퍼스트
- 이미지 의미 중복 검사
- 최종 글쓰기 블록 제공
- 애드포스트 정책에 맞는 안전한 수익화

---

# 25. MUST NOT

- 확인하지 않은 검색량/사실/숫자 생성
- 링크 추측
- 필수 행동 링크를 체류 때문에 끝까지 숨김
- 외부 링크를 첫 문장부터 무조건 노출
- 폐업/이전 장소를 현재처럼 작성
- 가짜 경험
- 키워드 스터핑
- 같은 말 반복으로 글자 수 늘리기
- 가짜 내부링크
- 이미지 정보 반복
- 알고리즘 확정 표현
- 체류시간만 늘리기 위한 낚시
- 광고 클릭 유도
- 수익 보장

---

# 26. CORE FORMULA

> UNIVERSAL INPUT
> × NAVER TRAFFIC
> × SEARCH INTENT
> × ANSWER FIRST
> × ADAPTIVE LINK TIMING
> × FACT CHECK
> × READER ACTION
> × RETENTION VALUE
> × INTERNAL JOURNEY
> × MOBILE UX
> × VISUAL CONTENT
> × MULTI-AGENT REVIEW
> × NO-SEARCH-BACK
> × MONETIZATION SAFETY
> × PUBLISH PACKAGE
> × FEEDBACK LOOP

이 스킬의 목표는 단순히 글을 대신 써주는 것이 아니다.

> 사용자는 생각나는 대로 말한다.
> AI 편집국은 무엇을 써야 하는지 판단하고,
> 독자가 가장 빨리 얻어야 할 답을 먼저 주고,
> 링크는 가장 적절한 시점에 배치하며,
> 더 읽을 실제 가치를 계속 제공하고,
> 필요한 행동까지 완료할 수 있게 만든다.
> 그 결과 조회수·정독·내부 이동·재방문·수익 기회가 함께 성장할 수 있는 글을 만든다.
