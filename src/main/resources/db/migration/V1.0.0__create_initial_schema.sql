create table if not exists families (
    family_id bigserial primary key,
    owner_id bigint not null references users(user_id)
);

create table if not exists children (
    child_id bigserial primary key,
    family_id bigint not null references families(family_id),
    status varchar(80) not null default 'ACTIVE'
);

create table if not exists users (
    user_id bigserial primary key
);

create table if not exists family_memberships (
    id bigserial primary key,
    family_id bigint not null references families(family_id),
    user_id bigint not null references users(user_id),
    created_at timestamptz not null default current_timestamp,
    updated_at timestamptz not null default current_timestamp,
    status varchar(80) not null default 'active',
    role varchar(80) not null references roles(role_name),

    constraint uq_family_membership unique (family_id, user_id)
    );

create table if not exists roles (
    role_name varchar(80) not null check (role_name in ('OWNER', 'PARENT', 'CAREGIVER')) primary key
);

insert into roles (role_name)
values
    ('OWNER'),
    ('PARENT'),
    ('CAREGIVER');

create table if not exists permissions (
    operation varchar(80) not null primary key
);

insert into permissions (operation)
values
    ('VIEW_FAMILY'),
    ('MANAGE_FAMILY'),
    ('INVITE_MEMBERS'),
    ('MANAGE_MEMBERS'),
    ('MANAGE_CHILDREN'),
    ('MANAGE_TASKS'),
    ('ASSIGN_TASKS'),
    ('VIEW_TASKS'),
    ('COMPLETE_TASKS'),
    ('CANCEL_TASKS'),
    ('VIEW_ACTIVITY');

create table if not exists role_permissions (
    operation varchar(80) not null references permissions(operation),
    role varchar(80) not null references roles(role_name),
    primary key (operation, role)
);

insert into role_permissions (operation, role)
select operation, 'OWNER'
from permissions;

insert into role_permissions (operation, role)
select operation, 'PARENT'
from permissions
where operation not in ('MANAGE_FAMILY', 'MANAGE_MEMBERS');

insert into role_permissions (operation, role)
select operation, 'CAREGIVER'
from permissions
where operation in ('VIEW_FAMILY', 'VIEW_TASKS', 'COMPLETE_TASKS', 'VIEW_ACTIVITY');

create table if not exists family_invitations (
    id bigserial primary key,
    role varchar(80) not null references roles(role_name),
    sender bigint not null references users(user_id),
    recipient varchar(255) not null,
    family_id bigint not null references families(family_id),
    token varchar(255) not null unique,
    expires_at timestamptz not null,
    status varchar(80) not null default 'PENDING'
);

