-- migrate:up
-- 파일 내용/블롭 저장을 하지 않고 "트리 구조(경로)"만 저장하도록 변경
alter table files drop column object_key;
alter table files drop column content_type;
alter table files drop column size;
alter table files add column path text not null default '';
alter table files add constraint files_space_path_unique unique (space_id, path);

-- migrate:down
alter table files drop constraint files_space_path_unique;
alter table files drop column path;
alter table files add column size bigint not null default 0;
alter table files add column content_type text not null default 'application/octet-stream';
alter table files add column object_key text not null default '';
