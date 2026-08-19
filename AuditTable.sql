create table audit_log(
    audit_id     number,
    user_id      number,
    action_type  varchar2(10),
    table_name   varchar2(50),
    record_id    number,
    action_date  date
);

--- primary key ---
alter table audit_log add constraint pk_audit_id primary key(audit_id);

--- foreign key ---
alter table audit_log add Constraint fk_audit_log_user_id foreign key(user_id) references users_mode(user_id);

--- not null ---
alter Table audit_log modify user_id not null;

alter table audit_log modify action_type not null;

alter table audit_log modify table_name not null;

alter table audit_log modify record_id not null;

--- check ---
alter table audit_log add constraint ck_audit_action_type check(upper(action_type) in ('INSERT','UPDATE','DELETE'));

--- default ---
alter table audit_log modify action_date default(sysdate);