# semicolon-db

세미콜론 동아리 통합 플랫폼 — **데이터베이스**

## 역할
이 레포가 **DB 스키마의 단일 진실 공급원(source of truth)**.

- 스키마 + 마이그레이션 (SQL, `dbmate`)
- 시드 데이터
- ERD / 데이터 모델 문서

## 호스팅
- **Supabase** (관리형 Postgres로만 사용 — Auth/Realtime/Storage 등 미사용)
- 연결: Session pooler 또는 Direct connection 문자열 사용 (Transaction pooler 6543은 `pg` prepared statement와 충돌하므로 회피), SSL 필수

## 소비처
- `semicolon-backend` 가 이 스키마에 연결하고, `kysely-codegen` 으로 TypeScript 타입을 생성해 사용.
