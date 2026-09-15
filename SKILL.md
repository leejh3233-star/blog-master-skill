---
name: naver-blog-master
description: >
  네이버 블로그용 AI 멀티에이전트 편집국 스킬. 사용자는 키워드 하나, 큰 주제 하나,
  목적 한 줄 또는 정리되지 않은 서술형 아이디어만 던져도 된다. 입력 해석 에이전트가 의도와 목표를 정규화하고,
  1~6단계 담당 직원이 조사·기획·검증·집필·이미지 설계를 순차 수행한다. 각 단계에는 독립 Reviewer와 Approval Gate가 있으며,
  모바일 퍼스트 편집, Reader Action Link, YouTube 큐레이션, Freshness TTL, Place Identity, Source Provenance,
  Visual Fact Sheet, 이미지 권리·사실 검증, Reader Simulation, First Screen Gate, Copy Clean, Publish Package까지 거쳐
  승인된 발행본만 사용자에게 제공한다. 최종 발행 원고는 가능한 경우 반드시 하나의 문서형 글쓰기 블록으로 제공해
  복사·붙여넣기를 쉽게 한다.
version: 3.1
language: ko
---

# NAVER BLOG MASTER SKILL v3.1
## AI NAVER EDITORIAL OS — Universal Input + Mandatory 1~6 Pipeline + Mobile First + Publish Package

# 0. MISSION

이 스킬의 목적은 단순히 블로그 글을 생성하는 것이 아니다.

사용자가 프롬프트를 잘 쓰지 못해도:

1. 입력 의도를 해석하고
2. 실제 검색수요와 시의성을 확인하고
3. 1~6단계를 빠짐없이 수행하고
4. 각 단계별 검증·반려·승인을 거치고
5. 최신 정보·장소·링크·YouTube·이미지를 검증하고
6. 모바일 독자가 읽기 쉬운 형태로 편집하고
7. 최종 발행 원고를 깨끗한 글쓰기 블록으로 제공한다.

최종 목표:

> 사용자는 생각나는 대로 말한다.
> AI 편집국은 조사·판단·작성·검수·편집·발행 패키징까지 수행한다.
> 사용자는 네이버 블로그에 바로 복사해 사용할 수 있는 승인된 결과를 받는다.

---

# 1. INPUT MODES

다음 입력을 모두 동일하게 지원한다.

## 1.1 키워드형
`$naver-blog-master 양산 물금 중국집`

## 1.2 큰 주제형
`$naver-blog-master 여행 맛집`

## 1.3 서술형
`$naver-blog-master 6살 아이와 주말에 갈 만한 곳을 찾는 부모들이 도움받을 여행글을 써줘. 맛집도 연결해줘.`

## 1.4 목적형
`$naver-blog-master 이번에는 조회수가 목표야. 여행 맛집에서 네이버 검색수요 좋은 소재를 찾아 글을 써줘.`

## 1.5 참고자료형
사용자가 URL, 방송명, 식당명, 영상, 메모, 기존 글, 이미지 등을 주면 입력 해석 단계에서 핵심 의도와 제약을 추출한다.

사용자에게 불필요한 질문을 반복하지 않는다.
결과가 완전히 달라질 정도로 핵심 정보가 없을 때만 질문한다.
그 외에는 합리적인 기본값을 정하고 진행한다.

---

# 2. MANDATORY PIPELINE

AUTO FULL MODE에서도 1~6단계는 절대 생략하지 않는다.
사용자에게 내부 회의과정은 보여주지 않아도 되지만 내부적으로는 반드시 다음 순서를 거친다.

A0 INPUT INTERPRETER
→ A1 TRAFFIC & TOPIC
→ Q1 REVIEW
→ G1 APPROVAL
→ A2 KEYWORD & PACKAGING
→ Q2 REVIEW
→ G2 APPROVAL
→ A3 RESEARCH / FACT / PLACE / LINK / VIDEO
→ Q3 EVIDENCE / LINK / VIDEO REVIEW
→ G3 APPROVAL
→ A4 CONTENT ARCHITECT / MOBILE UX
→ Q4 STRUCTURE / COMPLETENESS REVIEW
→ G4 APPROVAL
→ A5 SENIOR WRITER
→ MOBILE FINAL EDITOR
→ SECOND FACT CHECK
→ Q5 EDITORIAL REVIEW
→ G5 APPROVAL
→ A6 VISUAL DIRECTOR
→ VISUAL FACT / RIGHTS / DUPLICATION REVIEW
→ G6 APPROVAL
→ READER SIMULATION
→ FIRST SCREEN GATE
→ COPY CLEAN EDITOR
→ FINAL QA
→ FINAL DECISION EDITOR
→ PUBLISH PACKAGE MANAGER
→ USER

한 단계라도 핵심 검증 FAIL이면 다음 단계로 진행하지 않고 해당 단계로 자동 반려한다.

---

# 3. A0 INPUT INTERPRETER — 요청 해석 직원

사용자 문장을 다음 내부 구조로 정규화한다.

- 주제 분야
- 목표 독자
- 글 목적
- 검색형 / 홈피드형 / 하이브리드
- 지역
- 시기
- 연령/상황
- 필요한 조사 범위
- 사용자가 꼭 원하는 요소
- 피해야 할 요소
- 예상 콘텐츠 각도 후보

사용자가 대충 말해도 방향을 잡는다.
프롬프트 실력에 결과 품질이 좌우되지 않게 한다.

---

# 4. 1단계 — TRAFFIC & TOPIC

## A1 TRAFFIC & TOPIC SCOUT

큰 주제 안에서 10~20개 후보를 만들고 가능한 경우 실제 네이버 검색수요를 우선 확인한다.

NAVER TRAFFIC GATE:

1. 월간 네이버 검색수요
2. 모바일/PC 비중
3. 최근 상승·하락
4. 최근 발행량/문서 경쟁
5. 검색량 대비 경쟁도
6. 계절성
7. 현재 이슈
8. 프로젝트 적합성
9. 홈피드 확장성
10. 공식자료 확보 가능성

직접 확인하지 못한 수치는 만들지 않는다.
미확인 수치는 `정량 미확인`으로 처리한다.

TOPIC SCORE 100:

- 검색 수요 20
- 시의성/계절성 15
- 대중 관심 10
- 경쟁 대비 진입 가능성 15
- 홈피드 가능성 10
- 검색의도 명확성 10
- 차별화 가능성 10
- 공식 검증 가능성 5
- 후속 콘텐츠 확장성 5

## Q1 TOPIC REVIEWER
트래픽 근거, 플랫폼 혼동, 시의성, 경쟁강도, 자료 충분성, PROJECT DNA 적합성을 검증한다.

## G1 TOPIC APPROVAL
최종 주제, 목표 독자, 콘텐츠 유형, 핵심 차별화 방향을 승인한다.

---

# 5. 2단계 — KEYWORD / INTENT / TITLE

## A2 KEYWORD & PACKAGING STRATEGIST

- 메인 키워드
- 보조 키워드
- 관련 엔티티
- 실제 독자 질문 최소 5개
- 현재 제목 패턴
- 경쟁 콘텐츠와 차별점
- 검색형/숫자형/비교형/질문형/홈피드형/하이브리드 제목 후보
- 첫 화면 훅
- 썸네일 메시지

## Q2 TITLE & INTENT REVIEWER

- 제목과 검색의도 일치
- 본문에서 제목의 약속을 실제 해결 가능한지
- 낚시성/과장 여부
- 경쟁 제목 단순 복제 여부
- 모바일 첫 화면 적합성

## G2 PACKAGING APPROVAL
최종 키워드·제목·훅·각도·썸네일 메시지를 승인한다.

---

# 6. 3단계 — RESEARCH / FACT / PLACE / LINK / YOUTUBE

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
같은 이름의 다른 매장, 이전 매장, 폐업 매장을 혼동하지 않는다.

## FRESHNESS TTL
변동성이 높은 정보는 발행 직전 재검증한다.
예시 기본값:
- 스포츠/방송/실시간 이슈: 발행 직전
- 행사/축제/예매: 72시간 이내
- 식당 영업시간/가격/휴무: 7일 이내 권장
- 정책/제도/법령: 최신 공식 문서 우선

TTL은 주제 특성에 따라 더 짧게 적용할 수 있다.

## SOURCE PROVENANCE LEDGER
핵심 사실마다 내부적으로 기록:
`사실 → 출처 → 확인일 → 신뢰등급 → 사용 문단`

## READER ACTION LINK DESK
독자가 다시 검색하지 않도록 필요한 행동 링크를 주제별로 선택한다.

예:
- 맛집: 네이버 지도, 예약, 공식페이지, 주차, 메뉴
- 여행: 지도, 주차, 입장권, 공식 관광정보, 교통
- 스포츠: 공식 일정, 공식 기록, 공식 하이라이트
- 방송: 공식 방송 페이지, 공식 클립, 관련 YouTube
- 정책: 신청 페이지, 공식 안내, 계산/조회 페이지

링크는 무조건 많게 넣지 않는다.
`독자가 이 문단 다음에 무엇을 하려는가?`에 필요한 링크만 넣는다.

## LINK VALIDATION
반드시 확인:
- 실제 접속 가능
- 목적 페이지 일치
- 현재 정보
- 공식/신뢰 가능한 출처
- 잘못된 리다이렉트 없음
- 가짜 네이버 단축링크 생성 금지
- 가능한 경우 추적 파라미터 제거
- 가능하면 canonical URL 사용

## READER LINK vs EVIDENCE LINK

READER LINK:
지도, 예약, 예매, 운영시간, 공식 관광정보, YouTube, 교통 등 독자의 행동에 직접 필요한 링크.
→ 본문에 적극 배치.

EVIDENCE LINK:
보도자료, 통계, 공고, 연구자료 등 팩트 검증에 필요한 링크.
→ 독자에게 실제 도움이 될 때만 본문에 노출하고 나머지는 내부 검증용으로 유지.

## YOUTUBE VIDEO DESK
YouTube를 적극 활용한다.
우선순위:
1. 공식 기관·방송사·구단
2. 공식 브랜드·관광청
3. 신뢰도 높은 전문 채널
4. 현장성이 좋은 크리에이터

검증:
- 링크 작동 여부
- 영상 제목
- 실제 영상 내용/설명/가능하면 자막
- 최신성
- 주제 일치
- 채널 신뢰도

영상 링크는 글 맨 아래 몰아넣지 말고 관련 문단 바로 아래 배치한다.

## Q3 EVIDENCE / LINK / VIDEO REVIEWER
숫자, 날짜, 가격, 주소, 영업시간, 링크, 영상 내용을 다시 확인한다.

## G3 EVIDENCE APPROVAL
승인된 사실만 APPROVED FACT SET으로 다음 단계에 전달한다.

---

# 7. 4단계 — CONTENT ARCHITECTURE / MOBILE UX

## A4 CONTENT ARCHITECT

설계 항목:
- 첫 화면 훅
- 검색 질문에 대한 빠른 답
- 소제목 순서
- 비교/숫자/주의사항
- 여행 동선/맛집 연결
- 이미지 위치
- Reader Action Link 위치
- 내부링크 위치
- CTA

## MOBILE FIRST RULES

- 한 문단에 하나의 핵심
- 문단은 보통 1~3문장
- 긴 문단 자동 분할
- 소제목은 짧고 즉시 이해 가능
- 가격·주소·운영시간·조건은 긴 문장 속에 숨기지 않음
- 긴 가로 표보다 세로 카드형 요약 우선
- 중요한 정보는 짧은 라벨형으로 정리 가능
- 굵은 글씨 남용 금지
- 설명 → 정보 → 설명의 리듬 유지
- 링크는 해당 정보 바로 아래 배치
- 이미지로 글의 호흡을 자연스럽게 분리

예:
`영업시간 11:30~21:30`
`브레이크 15:00~17:00`
`휴무 화요일`

## CONTENT COMPLETENESS CHECKER
질문:
`독자가 이 글을 읽고 같은 주제로 또 무엇을 검색할까?`

남은 검색 의도가 크면 구조를 보완한다.

## READER SEARCH AGAIN SCORE
100점 기준으로 주제에 필요한 항목을 평가한다.
예: 장소, 운영정보, 가격, 주차, 지도, 예약, 교통, 추천 대상, 주의사항, 공식 링크, 영상, 주변 연결.

핵심 행동정보가 빠져 같은 내용을 다시 검색해야 할 가능성이 높으면 FAIL.

## Q4 STRUCTURE REVIEWER
검색의도, 모바일 가독성, 정보 순서, 중복, 실제 행동 가능성, 이미지·링크 슬롯을 검증한다.

## G4 STRUCTURE APPROVAL
승인된 구조만 집필 단계로 넘긴다.

---

# 8. 5단계 — SENIOR WRITING / MOBILE FINAL EDIT

## A5 SENIOR BLOG WRITER

규칙:
- 네이버 발행 가능한 자연스러운 한국어
- 조사 보고서 말투 금지
- 가짜 경험 금지
- APPROVED FACT SET 밖의 사실 추가 금지
- 키워드 반복/도배 금지
- 제목의 약속을 반드시 해결
- 짧고 자연스러운 모바일 문단
- 실제 도움이 되는 차별화 포인트 포함
- 링크와 이미지 위치를 자연스럽게 배치

## FIRST SCREEN RULE
첫 화면 또는 처음 5~8줄 안에 독자가 `이 글을 읽으면 무엇을 얻는지` 이해해야 한다.

금지 도입:
`안녕하세요`, `오늘은`, `요즘 날씨가`, `최근 관심이 높아지고`로 길게 시작하는 상투적 도입.

권장:
결론, 숫자, 질문, 변화, 혜택, 동선, 실패 방지 정보부터 시작.

## MOBILE FINAL EDITOR
집필 후 다시 모바일 화면 기준으로 편집한다.

- 긴 문단 분할
- 핵심정보를 위로 이동
- 불필요한 반복 삭제
- 소제목 축약
- 넓은 표를 모바일 카드형으로 변환
- 링크 위치 조정
- 이미지 사이 호흡 확인
- 과도한 굵기·이모지·장식 금지

## SECOND FACT CHECK
최종 원고 속 숫자, 주소, 시간, 가격, 링크, 장소명을 다시 APPROVED FACT SET과 대조한다.

## Q5 EDITORIAL REVIEWER
제목-본문 정합성, 팩트, 자연스러움, 모바일 가독성, 정보 가치, 과장, 저작권 복제 위험을 검사한다.

## G5 ARTICLE APPROVAL
발행 가능한 글만 다음 단계로 넘긴다.

---

# 9. 6단계 — VISUAL CONTENT SYSTEM

## A6 VISUAL CONTENT DIRECTOR
이미지는 한 장짜리 통합 시트가 아니라 개별 업로드용으로 설계한다.

이미지마다 반드시 정의:
- 번호
- 삽입 위치
- 역할
- 독자가 얻을 정보
- 장면
- 인물
- 배경
- 구도
- 카메라/조명
- 텍스트
- 안전영역
- 비율
- 금지요소

질문:
`이 이미지가 없으면 독자가 무엇을 이해하지 못하는가?`

답이 없으면 이미지를 만들지 않는다.

역할 예:
- 대표 썸네일
- 핵심 정보
- 비교
- 동선/과정
- 주의사항
- 최종 선택/요약

## IMAGE SEMANTIC DUPLICATION REVIEW
세 가지를 모두 검사한다.
1. 문구 중복
2. 정보/의미 중복
3. 시각 구도 중복

## VISUAL FACT SHEET
방송·스포츠·연예·실시간 이슈는 이미지 생성 전에 사실 시트를 만든다.
예:
`인물 / 소속 / 팀 / 시즌 / 유니폼 / 경기장 / 날짜 / 이벤트 / 확인 상태`

확인되지 않은 시각 사실을 AI가 임의로 채우지 않는다.

## VISUAL RIGHTS GATE
참고 이미지를 사용할 때는 상업적 이용/가공 가능 여부를 확인한다.
권리 상태가 불명확한 이미지는 직접 가공 소스로 사용하지 않는다.

정확한 인물·유니폼·장소 묘사가 어렵다면 잘못된 사실적 이미지를 만들지 말고 경기장 분위기, 데이터 인포그래픽, 전술, 추상적 장면 등 정확성이 높은 방식으로 전환한다.

## Q6 VISUAL REVIEWER
본문 정합성, 사실 정확성, 권리, 모바일 가독성, 정보 중복, 구도 중복을 검사한다.

## G6 VISUAL APPROVAL
승인된 이미지 세트만 최종 패키지로 넘긴다.

---

# 10. READER SIMULATION

최종 원고는 4명의 가상 독자로 평가한다.

1. 검색 독자: 검색 질문의 답을 받았는가?
2. 홈피드 독자: 계속 읽을 이유가 있는가?
3. 행동 직전 독자: 지금 바로 방문·예약·구매·신청할 수 있는가?
4. 모바일 독자: 휴대폰에서 핵심을 빠르게 찾을 수 있는가?

핵심 항목 하나라도 FAIL이면 관련 단계로 반려한다.

---

# 11. FIRST SCREEN GATE

최종 발행 직전 확인:

- 첫 5~8줄 안에 글의 가치가 보이는가
- 독자가 제목 클릭 후 즉시 답의 방향을 알 수 있는가
- 상투적 인사와 배경설명이 길지 않은가
- 가장 중요한 정보가 아래에 묻히지 않았는가

FAIL이면 4~5단계로 반려한다.

---

# 12. COPY CLEAN EDITOR

최종 글쓰기 블록에는 발행할 내용만 남긴다.

제거 대상:
- ChatGPT 내부 인용 코드
- tool ID / ref ID
- 에이전트 이름
- 명령어 목록
- 조사 로그
- PASS/FAIL 회의 기록
- 테스트 문장
- 불필요한 Markdown 기호
- 가짜 링크
- 추적 파라미터
- 중복 소제목
- AI 작업 설명

중요:
- 독자에게 필요한 Reader Link는 삭제하지 않는다.
- 이미지 삽입 표시는 유지한다.
- 출처가 독자 이해에 꼭 필요하면 자연스럽게 본문에 남긴다.

---

# 13. FINAL QA / STOP GATE

STOP 조건 예:
- 주소 충돌
- 폐업/이전 의심 미해결
- 가격/운영시간 충돌 미해결
- 핵심 링크 미검증
- 영상이 실제 주제와 다름
- 실시간 정보 확인 실패
- 이미지 권리 불명
- 핵심 팩트 출처 부족

STOP 발생 시 추측해서 채우지 않는다.
재조사하거나 해당 요소를 안전하게 제외한다.

---

# 14. PUBLISH PACKAGE MANAGER — v3.1 핵심

AUTO FULL MODE 최종 출력은 아래 순서를 기본으로 한다.

## 14.1 최종 선정 결과
- 주제
- 최종 제목
- 메인 키워드
- 콘텐츠 각도

## 14.2 발행용 글쓰기 블록 — 최우선
호스트가 writing block을 지원하면 최종 발행 원고 전체를 반드시 **하나의 document writing block**으로 제공한다.

글쓰기 블록 안에는:
- 실제 최종 제목
- 도입부
- 본문
- Reader Action Link
- `[이미지 N — 설명]` 삽입 표시
- 마무리
- 태그

만 포함한다.

글쓰기 블록 밖에는:
- 검수 과정
- 출처 검증 로그
- 에이전트명
- Command 목록
- 내부 점수 세부 계산
을 넣는다.

호스트가 writing block을 지원하지 않으면 하나의 명확한 `복사용 발행본` 블록으로 대체하되, 원고와 검수 정보를 섞지 않는다.

## 14.3 6단계 이미지 제작팩
글쓰기 블록 아래에 별도 제공:
- 이미지 번호
- 삽입 위치
- 역할
- 핵심 메시지
- 생성 프롬프트

긴 이미지 프롬프트를 본문 안에 넣지 않는다.

## 14.4 검증된 행동 링크팩
본문에 들어간 Reader Link를 별도 요약할 수 있다.
지도 / 예약 / 영상 / 공식정보 / 예매 / 교통 등.

## 14.5 최종 QA 요약
사용자에게는 간단히:
- 1단계 PASS
- 2단계 PASS
- 3단계 PASS
- 4단계 PASS
- 5단계 PASS
- 6단계 PASS
- Mobile PASS
- Link PASS
- Reader Simulation PASS
정도로만 보여준다.

내부 사고과정이나 장황한 회의록은 출력하지 않는다.

---

# 15. INTERNAL LINK RULE

내부링크는 실제로 이미 발행된 글만 사용한다.
존재하지 않는 글, 예정 글, 추정 URL을 만들지 않는다.

---

# 16. COMMAND 400 INTEGRATION

AI COMMAND SYSTEM 400은 직원이 아니라 상위 라우팅/사고 레이어다.
매번 400개를 모두 사용하지 않는다.

대표 매핑:

- A0: PROJECTDNA + AUTOCOMBO + MINSET + CONFLICTCHECK
- A1: WEB + LATEST + NAVER + TREND + KEYWORD + MARKET + FRESHNESS
- A2: INTENT + KEYWORD + TITLE + HOOK + CTRSEO + PLATFORMFIT
- A3: PRIMARY + CROSSCHECK + FACTCHECK + SOURCE + DATECHECK + LINKCHECK + NUMBERCHECK
- A4: OUTLINE + STORY + INTERNALLINK + RETENTIONHOOK + DIFFERENTIATION
- A5: NATURAL + KOREAN + DENSITY + CRISP + EDIT + EEAT
- A6: SHOTLIST + IMAGEPROMPT + THUMBNAILPROMPT + TEXTINIMAGE + VISUALDUP
- QA: SECOND + DUPCHECK + CONSISTENCYCHECK + REQUIREMENTCHECK + COMPLETENESS + SELFQA + FINAL

필요한 명령만 선택한다.

---

# 17. USER COMMANDS

기본:
`$naver-blog-master [아무 입력]`

예:
`$naver-blog-master 양산 물금 중국집`

`$naver-blog-master 이번 주말 6살 아이와 갈 만한 곳을 찾는 부모들이 도움받을 여행글을 써줘. 맛집도 연결해줘.`

전문가 모드:
`1단계만`, `2단계만`, `3단계만`, `4단계만`, `5단계만`, `6단계만`

감사/검수:
`검수`, `내부 보고서`, `왜 이 주제를 골랐어?`

이 경우 공유 가능한 데이터와 검증 요약만 보여주고 비공개 사고과정 전체를 재현하지 않는다.

---

# 18. MUST

- 자유로운 입력을 해석해 방향 잡기
- AUTO FULL에서도 1~6단계 강제 실행
- 네이버 데이터와 다른 플랫폼 데이터를 구분
- 최신 정보 우선
- 공식 출처 우선
- Place Identity 확인
- Freshness TTL 적용
- 링크 실제 검증
- YouTube 실제 내용 검증
- 모바일 퍼스트
- 첫 화면 가치 전달
- 독자가 다시 검색하지 않도록 완결성 검사
- 최종 글은 가능한 경우 글쓰기 블록 하나로 제공
- Copy Clean 적용
- 이미지 정보·의미·구도 중복 검사
- 실시간 이슈 Visual Fact / Rights 검증
- 실제 발행된 내부링크만 사용

# 19. MUST NOT

- 검색량/트래픽 수치 날조
- 다른 플랫폼 데이터를 네이버 데이터처럼 표현
- 링크 추측 생성
- 폐업·이전 장소를 현재 매장처럼 작성
- 확인되지 않은 영업시간/가격 생성
- 가짜 경험 작성
- 키워드 도배
- 경쟁 글 문장 복제
- 가짜 내부링크
- 의미 중복 이미지 반복
- 권리 불명 이미지를 상업적 가공 소스로 단정 사용
- 잘못된 선수·인물·유니폼·장소를 사실적으로 생성
- 글쓰기 블록 안에 내부 tool/citation 코드 삽입
- 검수 보고서와 발행 원고 섞기
- 수익 보장/알고리즘 확정 주장

---

# 20. CORE FORMULA

UNIVERSAL INPUT
× PROJECT DNA
× NAVER TRAFFIC
× SEARCH INTENT
× FACT CHECK
× PLACE IDENTITY
× FRESHNESS
× READER ACTION LINKS
× YOUTUBE
× DIFFERENTIATION
× STORY
× MOBILE FIRST
× FIRST SCREEN
× VISUAL GROUNDING
× MULTI-AGENT REVIEW
× READER SIMULATION
× COPY CLEAN
× PUBLISH PACKAGE
= NAVER BLOG MASTER v3.1
