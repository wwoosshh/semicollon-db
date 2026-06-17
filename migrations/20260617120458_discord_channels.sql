-- migrate:up
-- 파일 종속 채팅방 폐기 → 디스코드식 독립 채널 전환
delete from chat_channels where file_id is not null;
alter table chat_channels drop column file_id;
alter table chat_channels add column category text not null default '일반';
alter table chat_channels add column type text not null default 'text';
alter table chat_channels add column position integer not null default 0;
create index chat_channels_space_pos_idx on chat_channels (space_id, position);

drop table files;

-- migrate:down
create table files (
  id uuid primary key default gen_random_uuid(),
  space_id uuid not null references spaces (id) on delete cascade,
  uploaded_by uuid not null references users (id) on delete cascade,
  name text not null,
  path text not null default '',
  created_at timestamptz not null default now(),
  constraint files_space_path_unique unique (space_id, path)
);
drop index chat_channels_space_pos_idx;
alter table chat_channels drop column position;
alter table chat_channels drop column type;
alter table chat_channels drop column category;
alter table chat_channels add column file_id uuid references files (id) on delete cascade;
