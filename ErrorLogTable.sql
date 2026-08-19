create table error_log(
    error_id       number,
    user_id        number,
    procedure_name varchar2(100),
    error_code     number,
    error_message  varchar2(4000),
    error_date     date
);
-- primary key
alter table error_log add constraint pk_error_id primary key(error_id);

-- foreign key
alter table error_log add constraint fk_error_log_user_id foreign key(user_id) references users_mode(user_id);

-- not null
alter table error_log modify procedure_name not null;

alter table error_log  modify error_code not null;

alter table error_log modify error_message not null;

-- default date
alter table error_log modify error_date default sysdate;