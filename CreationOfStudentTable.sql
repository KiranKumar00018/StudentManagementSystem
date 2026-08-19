

CREATE TABLE students (
    student_id      NUMBER,
    student_name    VARCHAR2(90),
    date_of_birth   DATE,
    gender          VARCHAR2(2),
    email           VARCHAR2(90),
    phone           VARCHAR2(10),
    department_id   NUMBER,
    status          VARCHAR2(30),
    created_date    DATE
);

-- Primary Key
ALTER TABLE students ADD CONSTRAINT pk_student_id PRIMARY KEY (student_id);

-- Required fields
ALTER TABLE students MODIFY student_name VARCHAR2(90) NOT NULL;

ALTER TABLE students MODIFY gender VARCHAR2(2) NOT NULL;

ALTER TABLE students MODIFY status VARCHAR2(30) NOT NULL;

-- Gender validation
ALTER TABLE students ADD CONSTRAINT chk_gender CHECK (UPPER(gender) IN ('F', 'M'));

-- Phone validation
ALTER TABLE students ADD CONSTRAINT chk_phone CHECK (LENGTH(phone) = 10);

-- Department foreign key
ALTER TABLE students ADD CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- Status validation
ALTER TABLE students ADD CONSTRAINT ck_status CHECK (UPPER(status) IN ('ACTIVE', 'INACTIVE'));

-- Default creation date
ALTER TABLE students MODIFY created_date DEFAULT SYSDATE;