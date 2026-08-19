create table attendance(
    student_id  Number,
    subject_id Number,
    attendance_date  date,
    status  varchar2(10)
);

--- foreign key ----
  alter table attendance add constraint fk_attendance_student_id foreign key(student_id) references students(student_id);
    alter table attendance add constraint fk_attendance_subject_id foreign key(subject_id) references subjects(subject_id);
 --- default ---
 alter table attendance modify attendance_date default(sysdate);
 ---- req ==> A student can have only one attendance record for a particular subject on a particular date ---
   alter table attendance add constraint uq_student_id_subject_id_attendance_date unique(student_id,subject_id,attendance_date);
---- req ==> status can have only one value either p (pressent) or a (absent) ----
    alter table attendance add constraint ck_attendance_status check(upper(status) in ('P','A'));
