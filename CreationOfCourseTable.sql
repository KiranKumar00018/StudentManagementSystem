create table courses(
COURSE_ID number,
COURSE_NAME varchar2(56),
COURSE_CODE varchar2(56),
DEPARTMENT_ID number,
STATUS VARCHAR2(34),
CREATED_DATE date
);

----- primary key ------------
  alter table courses add constraint pk_COURSE_ID primary key(COURSE_ID);
----- not null ------------
    alter table courses modify COURSE_NAME not null;
---- foreign key -------
  alter table courses add constraint fk_course_DEPARTMENT_ID foreign key(DEPARTMENT_ID) references departments(DEPARTMENT_ID);
---- defualt Sysdate -----
 alter table courses modify CREATED_DATE date default(sysdate);
 --- unique ------
 alter table courses add constraint uq_COURSE_CODE unique(COURSE_CODE);
 ---- check -----
  alter table courses add constraint ck_course_status check(upper(status)in('ACTIVE','INACTIVE'));