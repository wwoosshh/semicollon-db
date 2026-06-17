-- migrate:up
create type space_type as enum ('프로젝트', '세미나', '코딩대회', '해커톤');
create type space_status as enum ('제안중', '모집중', '진행중', '완료', '보관');
create type space_role as enum ('리더', '멤버');
create type content_scope as enum ('전체', 'space');

create table spaces (
  id uuid primary key default gen_random_uuid(),
  type space_type not null,
  title text not null,
  description text not null default '',
  status space_status not null default '제안중',
  created_by uuid not null references users (id) on delete cascade,
  created_at timestamptz not null default now()
);

create table memberships (
  space_id uuid not null references spaces (id) on delete cascade,
  user_id uuid not null references users (id) on delete cascade,
  role space_role not null default '멤버',
  joined_at timestamptz not null default now(),
  primary key (space_id, user_id)
);

create table announcements (
  id uuid primary key default gen_random_uuid(),
  scope content_scope not null,
  space_id uuid references spaces (id) on delete cascade,
  author_id uuid not null references users (id) on delete cascade,
  title text not null,
  body text not null default '',
  created_at timestamptz not null default now()
);

create table posts (
  id uuid primary key default gen_random_uuid(),
  scope content_scope not null,
  space_id uuid references spaces (id) on delete cascade,
  author_id uuid not null references users (id) on delete cascade,
  title text not null,
  body text not null default '',
  created_at timestamptz not null default now()
);

create table comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references posts (id) on delete cascade,
  author_id uuid not null references users (id) on delete cascade,
  body text not null,
  created_at timestamptz not null default now()
);

create index spaces_status_idx on spaces (status);
create index memberships_user_idx on memberships (user_id);
create index announcements_space_idx on announcements (space_id);
create index posts_space_idx on posts (space_id);
create index comments_post_idx on comments (post_id);

-- migrate:down
drop table comments;
drop table posts;
drop table announcements;
drop table memberships;
drop table spaces;
drop type content_scope;
drop type space_role;
drop type space_status;
drop type space_type;
