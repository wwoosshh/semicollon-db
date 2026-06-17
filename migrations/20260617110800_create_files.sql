-- migrate:up
create table files (
  id uuid primary key default gen_random_uuid(),
  space_id uuid not null references spaces (id) on delete cascade,
  uploaded_by uuid not null references users (id) on delete cascade,
  name text not null,
  object_key text not null,
  size bigint not null default 0,
  content_type text not null default 'application/octet-stream',
  created_at timestamptz not null default now()
);
create index files_space_idx on files (space_id);

-- 파일별 채팅 채널 지원: 채널이 특정 파일에 속할 수 있음 (file_id null = 공간 메인 채널)
alter table chat_channels add column file_id uuid references files (id) on delete cascade;
create index chat_channels_file_idx on chat_channels (file_id);

-- migrate:down
alter table chat_channels drop column file_id;
drop table files;
