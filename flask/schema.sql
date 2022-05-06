CREATE TABLE STAGING_PAYROLL
(
   fiscal_year INTEGER,
   payroll_number VARCHAR(100),
   agency_name VARCHAR(500),
   last_name VARCHAR(500),
   first_name VARCHAR(500),
   agency_start_date DATE,
   work_location_borough VARCHAR(500),
   title_description VARCHAR(500),
   leave_status_as_of_july_31 
VARCHAR(500),
   base_salary NUMERIC(30,3),
   pay_basis VARCHAR(500),
   regular_hours NUMERIC(30,3),
   regular_gross_paid NUMERIC(30,3),
   ot_hours NUMERIC(30,3),
   total_ot_paid NUMERIC(30,3),
   total_other_pay NUMERIC(30,3)
);
 
 
select * from STAGING_PAYROLL limit 100;
 
CREATE TABLE AGENCY (
   agency_id INTEGER PRIMARY KEY 
AutoIncrement,
   agency_name TEXT
);
 
insert into AGENCY(agency_name)
SELECT DISTINCT agency_name from 
STAGING_PAYROLL;
 
 
select * from AGENCY;
 
 
 
CREATE TABLE EMPLOYEE (
   employee_id INTEGER PRIMARY KEY 
AUTOINCREMENT,
   last_name TEXT,
   first_name TEXT,
   agency_id INTEGER,
   agency_start_date DATE,
   FOREIGN KEY(agency_id) REFERENCES 
Agency(agency_id)
);
 
INSERT into EMPLOYEE(last_name ,
   first_name,
   agency_id ,
   agency_start_date)
select distinct last_name, first_name, 
agency_id, agency_start_date from 
STAGING_PAYROLL S INNER JOIN AGENCY A  
on S.AGENCY_NAME = A.AGency_name ;
 
 
 
DROP TABLE PAYROLL;
 
CREATE TABLE PAYROLL(
   payroll_id INTEGER PRIMARY KEY 
AUTOINCREMENT,
   payroll_number TEXT,
   Employee_ID INTEGER,
   base_salary DOUBLE,
   pay_basis DOUBLE,
   regular_hours DOUBLE,
   regular_gross_paid DOUBLE,
   ot_hours DOUBLE,
   total_ot_paid DOUBLE,
   total_other_pay DOUBLE,
   fiscal_year INTEGER,
   leave_status_as_of_july_31 TEXT,
   work_location_borough TEXT,
   title_description TEXT
);
 
INSERT INTO PAYROLL(
   payroll_number ,
   Employee_ID ,
   base_salary ,
   pay_basis ,
   regular_hours ,
   regular_gross_paid ,
   ot_hours ,
   total_ot_paid ,
   total_other_pay ,
   fiscal_year ,
   leave_status_as_of_july_31,
   work_location_borough ,
   title_description
)
SELECT
   PAYROLL_NUMBER,
   EMPLOYEE_ID,
   base_salary ,
   pay_basis ,
   regular_hours ,
   regular_gross_paid ,
   ot_hours ,
   total_ot_paid ,
   total_other_pay ,
   fiscal_year,
   leave_status_as_of_july_31,
   work_location_borough,
   title_description
    from STAGING_PAYROLL S INNER JOIN 
EMPLOYEE E on s.last_name =E.Last_name 
and  s.first_name = e.first_name and  
s.agency_start_date = 
e.agency_start_date
    INNER JOIN AGENCY A on a.agency_name 
= s.agency_name  and e.agency_id = 
a.agency_id;
 
 
SELECT * FROM EMPLOYEE E , AGENCY A, 
PAYROLL P
WHERE E.EMPLOYEE_ID = P.EMPLOYEE_ID and 
A.AGENCY_ID = E.AGENCY_ID and 
P.EMPLOYEE_ID = E.EMPLOYEE_ID order by 
regular_gross_paid desc limit 100;


