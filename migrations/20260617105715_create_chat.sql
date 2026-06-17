-- migrate:up
create table chat_channels (
  id uuid primary key default gen_random_uuid(),
  space_id uuid not null references spaces (id) on delete cascade,
  name text not null default '메인',
  created_at timestamptz not null default now()
);

create table messages (
  id uuid primary key default gen_random_uuid(),
  channel_id uuid not null references chat_channels (id) on delete cascade,
  author_id uuid not null references users (id) on delete cascade,
  body text not null,
  created_at timestamptz not null default now()
);

create index chat_channels_space_idx on chat_channels (space_id);
create index messages_channel_idx on messages (channel_id, created_at);

-- migrate:down
drop table messages;
drop table chat_channels;
