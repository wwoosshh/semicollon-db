-- migrate:up
create table settings (
  key text primary key,
  value text not null
);
insert into settings (key, value) values ('invite_code', 'semicolon2026');

-- migrate:down
drop table settings;
