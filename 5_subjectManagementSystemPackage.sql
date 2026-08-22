
---======= package specification ====---
CREATE OR REPLACE PACKAGE pkg_subjectmanagement
IS
   PROCEDURE sp_add_subject(p_subject_name subjects.subject_name%TYPE,
                            p_course_id subjects.course_id%TYPE,
                            p_status subjects.status%TYPE,
                            p_user_id NUMBER);

   PROCEDURE sp_update_subject(p_subject_id subjects.subject_id%TYPE,
                               p_subject_name subjects.subject_name%TYPE,
                               p_course_id subjects.course_id%TYPE,
                               p_status subjects.status%TYPE,
                               p_user_id NUMBER);

   PROCEDURE sp_deactivate_subject(p_subject_id subjects.subject_id%TYPE,
                                   p_user_id NUMBER);

   FUNCTION sf_get_subject(p_subject_id subjects.subject_id%TYPE,
                           p_user_id NUMBER) RETURN subjects%ROWTYPE;
END pkg_subjectmanagement;
/

---================================================================================---
------===== package body ====------

CREATE OR REPLACE PACKAGE BODY pkg_subjectmanagement
IS
   --- adding subject procedure ---
   
   PROCEDURE sp_add_subject(p_subject_name subjects.subject_name%TYPE,
                            p_course_id subjects.course_id%TYPE,
                            p_status subjects.status%TYPE,
                            p_user_id NUMBER)
   IS
      v_error_message VARCHAR2(3500);
      v_error_backtrace VARCHAR2(3500);
   BEGIN
      IF p_user_id IS NULL THEN
         RAISE_APPLICATION_ERROR(-20001,'you should enter user id');
      ELSIF p_subject_name IS NULL THEN
         RAISE_APPLICATION_ERROR(-20002,'you should enter subject name');
      ELSE
         INSERT INTO subjects(subject_id,subject_name,course_id,status,created_date)
         VALUES(sq_subject_id.NEXTVAL,p_subject_name,p_course_id,p_status,SYSDATE);
         COMMIT;
         DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' rows added');
         DBMS_OUTPUT.PUT_LINE('adding successfully completed');
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         v_error_message:=SQLERRM;
         v_error_backtrace:=DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         INSERT INTO error_log(error_id,user_id,procedure_name,error_message,error_code_line)
         VALUES(sq_error_id.NEXTVAL,p_user_id,'sp_add_subject',v_error_message,v_error_backtrace);
         COMMIT;
         RAISE_APPLICATION_ERROR(-200077,v_error_message||' '||v_error_backtrace);
   END sp_add_subject;

   --- updating subject procedure ---
   
   PROCEDURE sp_update_subject(p_subject_id subjects.subject_id%TYPE,
                               p_subject_name subjects.subject_name%TYPE,
                               p_course_id subjects.course_id%TYPE,
                               p_status subjects.status%TYPE,
                               p_user_id NUMBER)
   IS
      v_error_message VARCHAR2(3500);
      v_error_backtrace VARCHAR2(3500);
   BEGIN
      IF p_subject_id IS NULL OR p_user_id IS NULL THEN
         RAISE_APPLICATION_ERROR(-20003,'you should enter subject id as well as user id');
      ELSE
         UPDATE subjects s
         SET s.subject_name=NVL(p_subject_name,s.subject_name),
             s.course_id=NVL(p_course_id,s.course_id),
             s.status=NVL(p_status,s.status)
         WHERE s.subject_id=p_subject_id;

         IF SQL%ROWCOUNT=0 THEN
            RAISE_APPLICATION_ERROR(-20004,'subject not found');
         ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' rows updated');
            DBMS_OUTPUT.PUT_LINE('update successfully completed');
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         v_error_message:=SQLERRM;
         v_error_backtrace:=DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         INSERT INTO error_log(error_id,user_id,procedure_name,error_message,error_code_line)
         VALUES(sq_error_id.NEXTVAL,p_user_id,'sp_update_subject',v_error_message,v_error_backtrace);
         COMMIT;
         RAISE_APPLICATION_ERROR(-200077,v_error_message||' '||v_error_backtrace);
   END sp_update_subject;

   --- deactivating subject procedure ---
   
   PROCEDURE sp_deactivate_subject(p_subject_id subjects.subject_id%TYPE,
                                   p_user_id NUMBER)
   IS
      v_error_message VARCHAR2(3500);
      v_error_backtrace VARCHAR2(3500);
   BEGIN
      IF p_subject_id IS NULL OR p_user_id IS NULL THEN
         RAISE_APPLICATION_ERROR(-20005,'you should enter subject id as well as user id');
      ELSE
         UPDATE subjects
         SET status='INACTIVE'
         WHERE subject_id=p_subject_id;

         IF SQL%ROWCOUNT=0 THEN
            RAISE_APPLICATION_ERROR(-20004,'subject not found');
         ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' rows deactivated');
            DBMS_OUTPUT.PUT_LINE('deactivated successfully completed');
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         v_error_message:=SQLERRM;
         v_error_backtrace:=DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         INSERT INTO error_log(error_id,user_id,procedure_name,error_message,error_code_line)
         VALUES(sq_error_id.NEXTVAL,p_user_id,'sp_deactivate_subject',v_error_message,v_error_backtrace);
         COMMIT;
         RAISE_APPLICATION_ERROR(-200077,v_error_message||' '||v_error_backtrace);
   END sp_deactivate_subject;

   --- getting subject details with function ---
   
   FUNCTION sf_get_subject(p_subject_id subjects.subject_id%TYPE,
                           p_user_id NUMBER) RETURN subjects%ROWTYPE
   IS
      v_subject_details subjects%ROWTYPE;
      v_error_message VARCHAR2(3500);
      v_error_backtrace VARCHAR2(3500);
   BEGIN
      IF p_subject_id IS NULL OR p_user_id IS NULL THEN
         RAISE_APPLICATION_ERROR(-20006,'you should enter subject id as well as user id');
      ELSE
         SELECT *
         INTO v_subject_details
         FROM subjects
         WHERE subject_id=p_subject_id;
      END IF;

      RETURN v_subject_details;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         v_error_message:='subject not found';
         v_error_backtrace:=DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         INSERT INTO error_log(error_id,user_id,procedure_name,error_message,error_code_line)
         VALUES(sq_error_id.NEXTVAL,p_user_id,'sf_get_subject',v_error_message,v_error_backtrace);
         COMMIT;
         RAISE_APPLICATION_ERROR(-20007,v_error_message);
      WHEN OTHERS THEN
         v_error_message:=SQLERRM;
         v_error_backtrace:=DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
         INSERT INTO error_log(error_id,user_id,procedure_name,error_message,error_code_line)
         VALUES(sq_error_id.NEXTVAL,p_user_id,'sf_get_subject',v_error_message,v_error_backtrace);
         COMMIT;
         RAISE_APPLICATION_ERROR(-200077,v_error_message||' '||v_error_backtrace);
   END sf_get_subject;
END pkg_subjectmanagement;
/

