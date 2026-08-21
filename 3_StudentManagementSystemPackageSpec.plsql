           ---======= package specification ====-------

CREATE or REPLACE PACKAGE pkg_studentmanagement
is
   procedure sp_update_student(p_student_id students.student_id%type, 
                               p_date_of_birth students.date_of_birth%type,
                               p_gender students.gender%type,
                               p_email students.email%type,
                               p_phone students.phone%type,
                               p_department_id students.department_id%type,
                               p_status students.status%type,
                               p_student_name students.student_name%type,
                               p_user_id number);
                               
   procedure sp_add_student(p_student_name students.student_name%type,
                            p_date_of_birth students.date_of_birth%type,
                            p_gender students.gender%type,
                            p_email students.email%type,
                            p_phone students.phone%type,
                            p_department_id students.department_id%type,
                            p_status students.status%type,
                            p_user_id number);
                            
   procedure sp_deactivate_student(p_student_id students.student_id%type,p_user_id number);
   
   function sf_get_student(p_student_id students.student_id%type,p_user_id number) return students%rowtype;
end pkg_studentmanagement;
/
