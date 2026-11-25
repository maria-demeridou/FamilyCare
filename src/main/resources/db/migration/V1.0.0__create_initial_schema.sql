create table if not exists families (
    family_id bigserial primary key,
    owner_id bigint not null references users(user_id)
);

create table if not exists children (
    child_id bigserial primary key,
    family_id bigint not null references families(family_id)
);

create table if not exists users (
    user_id bigserial primary key
);

create table if not exists family_memberships (
    id bigserial primary key,
    family_id bigint not null references families(family_id),
    user_id bigint not null references users(user_id),
    created_at timestamp not null default current_timestamp,
    updated_at timestamp not null default current_timestamp,
    status varchar(80) not null default 'active',
    role varchar(80) not null references roles(role_name),

    constraint uq_family_membership unique (family_id, user_id)
    );

create table if not exists roles (
    role_name varchar(80) not null check (role_name in ('OWNER', 'PARENT', 'CAREGIVER')) primary key
);

create table if not exists permissions (
    operation varchar(80) not null primary key
);

create table if not exists role_permission (
    operation varchar(80) not null references permissions(operation),
    role varchar(80) not null references roles(role_name),
    primary key (operation, role)
);

