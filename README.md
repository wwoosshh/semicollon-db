# semicolon-db

세미콜론 동아리 통합 플랫폼 — **데이터베이스**

## 역할
이 레포가 **DB 스키마의 단일 진실 공급원(source of truth)**.

- 스키마 + 마이그레이션 (SQL, `dbmate`)
- 시드 데이터
- ERD / 데이터 모델 문서

## 호스팅
- Railway Postgres (관리형)

## 소비처
- `semicolon-backend` 가 이 스키마에 연결하고, `kysely-codegen` 으로 TypeScript 타입을 생성해 사용.
