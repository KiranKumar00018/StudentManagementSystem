Create table fees (
    student_id   number,
    total_amount number,
    paid_amount number,
    due_date date,
    status varchar2(10),
    created_date date
);

--- forign key ------
 alter table fees Add Constraint fk_fees_student_id foreign key (student_id) references students(student_id);
-- not null ------
alter table fees modify total_amount not null;
alter table fees modify paid_amount not null;
alter table fees modify status not null;
--- req ==> total_amount is always grater then 0 and paid amount greater or equal to 0
alter table fees Add Constraint ck_total_amount check(total_amount>0);
alter table fees Add Constraint ck_paid_amount check(paid_amount>=0);
--- req ==> status should have two values either paid or pending
alter table fees Add Constraint ck_fees_status check(upper(status) in('PAID','PENDING'));
---- default -----
alter table fees modify created_date DEFAULT(SYSDATE);
alter table fees modify due_date DEFAULT(SYSDATE+30);
-- Paid amount cannot exceed total fee ----
alter table fees add constraint ck_fees_paid_total check (paid_amount <= total_amount);