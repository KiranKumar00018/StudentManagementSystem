create table users_mode(
user_id number,
username varchar2(41),
user_password varchar2(35),
Student_Id number,
user_role varchar2(20),
status varchar2(49),
created_date date
);

--- primary key ----
alter table users_mode add constraint pk_user_id primary key(user_id);
--- not null ---
alter table users_mode modify username not null;
alter table users_mode modify user_password not null;
alter table users_mode modify user_role not null;
alter table users_mode modify status not null;
---- unique key ---
alter table users_mode add constraint uq_username unique(username);
---- foreign key -----------
alter table users_mode add constraint fk_users_mode_Student_Id foreign key(Student_Id) references Students(Student_Id);
--- check() -------
alter table users_mode add constraint ck_user_role check(upper(user_role) in('FACULTY','STUDENT'));
alter table users_mode add constraint ck_users_mode_status check(upper(status)in('ACTIVE','INACTIVE'));
---- defaualt ------
alter table users_mode modify created_date default(sysdate);
