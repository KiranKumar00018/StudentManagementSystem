create table ENROLLMENTS(
ENROLLMENT_ID number,
STUDENT_ID number,
COURSE_ID number,
ENROLLMENT_DATE date,
STATUS varchar2(15)
);

---- primary key ------
alter table ENROLLMENTS add constraint pk_ENROLLMENT_ID primary key(ENROLLMENT_ID);
---- foreign keys -----
alter table ENROLLMENTS add constraint fk_ENROLLMENTS_STUDENT_ID foreign key(STUDENT_ID) references students(STUDENT_ID);
alter table ENROLLMENTS add constraint fk_ENROLLMENTS_COURSE_ID foreign key(COURSE_ID) references COURSES(COURSE_ID);
--- defualt ----
alter table ENROLLMENTS modify ENROLLMENT_DATE default(sysdate);
---- check ------
alter table ENROLLMENTS add constraint ck_ENROLLMENTS_STATUS check(upper(status)in('ACTIVE','INACTIVE'));
----- REQUIREMENT ==> The same student cannot enroll in the same course twice.-----
alter table ENROLLMENTS add constraint UQ_STUDENT_ID_COURSE_ID UNIQUE(STUDENT_ID,COURSE_ID);

