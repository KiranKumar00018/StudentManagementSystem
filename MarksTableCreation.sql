create table marks(
mark_id number,
student_Id number,
subject_id number,
marks number
);

--- primary key ------
alter table marks add constraint  pk_mark_id primary key(mark_id);
--- foreign key --------
alter table marks add constraint  fk_marks_student_id foreign key(student_Id) references students(student_Id);
alter table marks add constraint  fk_marks_subject_id foreign key(subject_id) references subjects(subject_id);
-- req ==> A student should have only one marks record for a particular subject ----
alter table marks add constraint uq_student_Id_subject_id unique(student_Id,subject_id);
-- req2 ==> marks should be greater then or equal to 0 and less then or equal to 100 ----
alter table marks add constraint ck_marks check(marks between 0 and 100);