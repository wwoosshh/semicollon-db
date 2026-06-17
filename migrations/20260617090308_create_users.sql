-- migrate:up
create type user_role as enum ('운영진', '부원');

create table users (
  id uuid primary key default gen_random_uuid(),
  email text unique not null,
  password_hash text not null,
  name text not null default '',
  role user_role not null default '부원',
  cohort integer,
  avatar_url text,
  created_at timestamptz not null default now()
);

create index users_role_idx on users (role);

-- migrate:down
drop table users;
drop type user_role;
