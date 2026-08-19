create table subjects(
subject_id number,
subject_name varchar(90),
course_id number,
status varchar(14),
created_date date
);

--- primary key ---
alter table subjects add constraint pk_subject_id primary key(subject_id);
--- not null -----
alter table subjects modify subject_name not null;
---- foreign key --------
alter table subjects add constraint fk_subjects_course_id foreign key(course_id) references courses(course_id);
--- check ------
alter table subjects add constraint ck_subjects_status check(upper(status)in('ACTIVE','INACTIVE'));
--- Defualt ---
alter table subjects modify created_date default(sysdate);

