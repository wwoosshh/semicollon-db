-- migrate:up
create type event_kind as enum ('정기모임', '세미나', '발표', '마감', '행사', '기타');
create type attendance_status as enum ('출석', '지각', '결석');

create table events (
  id uuid primary key default gen_random_uuid(),
  scope content_scope not null,
  space_id uuid references spaces (id) on delete cascade,
  title text not null,
  starts_at timestamptz not null,
  ends_at timestamptz,
  location text not null default '',
  kind event_kind not null default '기타',
  created_by uuid not null references users (id) on delete cascade,
  created_at timestamptz not null default now()
);

create table attendance (
  event_id uuid not null references events (id) on delete cascade,
  user_id uuid not null references users (id) on delete cascade,
  status attendance_status not null,
  checked_at timestamptz not null default now(),
  primary key (event_id, user_id)
);

create index events_starts_idx on events (starts_at);
create index events_space_idx on events (space_id);
create index attendance_user_idx on attendance (user_id);

-- migrate:down
drop table attendance;
drop table events;
drop type attendance_status;
drop type event_kind;
