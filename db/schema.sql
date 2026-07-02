CREATE TABLE users (
  id bigserial PRIMARY KEY,
  name varchar NOT NULL,
  email varchar NOT NULL UNIQUE,
  rfc varchar NOT NULL UNIQUE,
  password_digest varchar NOT NULL,
  session_token varchar,
  admin boolean NOT NULL DEFAULT false,
  created_at timestamp(6) NOT NULL,
  updated_at timestamp(6) NOT NULL
);

CREATE TABLE collaborators (
  id bigserial PRIMARY KEY,
  user_id bigint NOT NULL REFERENCES users(id),
  name varchar NOT NULL,
  email varchar NOT NULL,
  rfc text,
  fiscal_address text,
  curp text,
  nss text,
  start_date date NOT NULL,
  contract_type varchar NOT NULL,
  department varchar NOT NULL,
  position varchar NOT NULL,
  daily_salary numeric(12,2) NOT NULL,
  salary numeric(12,2) NOT NULL,
  entity_key varchar NOT NULL,
  state varchar NOT NULL,
  created_at timestamp(6) NOT NULL,
  updated_at timestamp(6) NOT NULL
);

CREATE INDEX index_collaborators_on_user_id ON collaborators(user_id);

CREATE TABLE managed_users (
  id bigserial PRIMARY KEY,
  owner_user_id bigint NOT NULL REFERENCES users(id),
  created_by_id bigint NOT NULL REFERENCES users(id),
  name varchar NOT NULL,
  rfc text,
  address varchar NOT NULL,
  phone varchar NOT NULL,
  website varchar NOT NULL,
  created_at timestamp(6) NOT NULL,
  updated_at timestamp(6) NOT NULL
);

CREATE INDEX index_managed_users_on_owner_user_id ON managed_users(owner_user_id);
CREATE INDEX index_managed_users_on_created_by_id ON managed_users(created_by_id);
