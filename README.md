# NAVER Blog Master Skill v2.2

네이버 블로그 글쓰기·운영을 위한 **멀티에이전트 AI 편집국 Skill**입니다.

사용자는 큰 주제만 정하면 됩니다.

```text
$naver-blog-master 양산 물금 맛집
```

그러면 내부에서 자동으로:

```text
총괄팀장
→ 주제·트래픽 직원
→ Reviewer / 승인
→ 키워드·제목 직원
→ Reviewer / 승인
→ 팩트·장소 직원
→ 링크 전담 직원
→ YouTube 큐레이터
→ 링크·영상 Reviewer
→ 본문 구조 직원
→ 완결성 검사
→ 집필 직원
→ 2차 팩트·Freshness 검증
→ 이미지 디렉터
→ Visual Fact / Rights / 중복 QA
→ Reader Simulation
→ 최종 QA
→ 편집장 승인
→ 사용자에게 결과만 전달
```

## v2.2 핵심 기능

- 큰 주제만 입력하는 AUTO FULL MODE
- PROJECT DNA 자동 생성·유지
- Command 400 기반 필요한 명령 자동 선택
- 네이버 실제 검색수요 기반 주제 발굴
- 검색량/경쟁도/계절성/시의성 검토
- 검색 + 홈피드 하이브리드 제목 설계
- 단계마다 독립 Reviewer + Approval Gate
- Place Identity: 상호·지점·주소·이전·폐업 확인
- Freshness TTL: 변동성 정보 발행 직전 재검증
- Source Provenance Ledger: 사실별 출처·확인일 내부 기록
- Reader Action Links: 지도·예약·주차·공식페이지·교통·예매 링크 제공
- YouTube 적극 활용: 공식/신뢰 영상 검색·내용·링크 검증
- Content Completeness: 독자가 다시 검색해야 할 정보가 남았는지 검사
- 최종 Reader Simulation: 검색형/홈피드형/행동형 독자 관점 검수
- 방송·스포츠·연예·실시간 이슈용 Visual Fact Sheet
- 상업적 이용/2차 저작 허용 여부를 확인한 참고자산 우선
- 권리 불명 이미지는 직접 재사용·가공 소스로 사용하지 않음
- 이미지 정보·의미·구도 중복 3중 검사
- 최종 QA + 최종 편집장 승인
- 성과 피드백 루프

## 가장 간단한 사용법

```text
$naver-blog-master 여행 맛집
```

```text
$naver-blog-master 양산 물금 맛집
```

```text
$naver-blog-master 프로야구 실시간 이슈
```

기본값은 **AUTO FULL MODE**입니다.

사용자는 내부 단계를 하나씩 승인할 필요가 없습니다.

## 최종적으로 받는 결과

1. 최종 선정 주제
2. 최종 제목
3. 네이버 발행용 완성 원고
4. 검증된 지도·예약·공식·교통 등 행동 링크
5. 검증된 YouTube 영상
6. 내부링크 제안
7. 이미지 삽입 위치
8. 개별 이미지 전략/프롬프트
9. 최종 검수 PASS 요약
10. 필요 시 후속 글 후보

## 특정 단계만 호출

```text
1단계만
3단계 링크까지
5단계만
6단계
검수
링크 다시 검증
영상 다시 검증
내부 보고서
```

## 이미지 원칙

특히 방송·스포츠·연예·실시간 이슈는 이미지 생성 전에 Visual Fact Sheet를 만듭니다.

- 날짜/시즌
- 인물·선수
- 팀/소속
- 경기장/장소
- 복장/유니폼
- 반드시 보여야 할 요소
- 생성하면 안 되는 요소

참고 이미지의 상업적 이용 가능 여부를 추측하지 않습니다.
Public Domain/CC0/상업적 2차 저작 허용 라이선스/사용자 소유 자산 등 권리가 확인된 자료를 우선합니다.

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

## 저장소

이 프로젝트는 사장님AI와 독립적으로 유지합니다.
필요할 때 외부 스킬 모듈로 호출할 수 있습니다.
