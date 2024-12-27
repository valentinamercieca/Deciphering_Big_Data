/* Creating a new database */
CREATE DATABASE StudentDatabase;
USE StudentDatabase;

/*--------------------------------------------------------------------*/

/* Creating the Tables */

/* Student Information Table */
CREATE TABLE Student_Information(
Student_Number INT PRIMARY KEY,
Student_Name VARCHAR(100) NOT NULL,
Exam_Score INT NOT NULL,
Support BOOLEAN NOT NULL,
Date_of_Birth DATE NOT NULL);
SHOW TABLES;

/* Teacher Information Table */
CREATE TABLE Teacher_Information(
Teacher_ID VARCHAR(10) PRIMARY KEY,
Teacher_Name VARCHAR(100) NOT NULL);
SHOW TABLES;

/* Course Information Table */
CREATE TABLE Course_Information(
Course_Name VARCHAR(100) PRIMARY KEY,
Exam_Boards VARCHAR(50) NOT NULL,
Teacher_ID VARCHAR(10) NOT NULL,
FOREIGN KEY(Teacher_ID) REFERENCES Teacher_Information(Teacher_ID));
SHOW TABLES;

/* Student-Course Enrollment Table */
CREATE TABLE Student_Course_Enrollment(
Student_Number INT,
Course_Name VARCHAR(100),
PRIMARY KEY(Student_Number, Course_Name),
FOREIGN KEY(Student_Number) REFERENCES Student_Information(Student_Number),
FOREIGN KEY(Course_Name) REFERENCES Course_Information(Course_Name));
SHOW TABLES;

/*--------------------------------------------------------------------*/

/* Populating the Tables */

/* Insert into Student Information */
INSERT INTO Student_Information VALUES (1001, 'Bob Baker', 78, FALSE, '2001-08-25');
INSERT INTO Student_Information VALUES (1002, 'Sally Davies', 55, TRUE, '1999-10-02');
INSERT INTO Student_Information VALUES (1003, 'Mark Hanmill', 90, FALSE, '1995-06-05');
INSERT INTO Student_Information VALUES (1004, 'Anas Ali', 70, FALSE, '1980-08-03');
INSERT INTO Student_Information VALUES (1005, 'Cheuk Yin', 45, TRUE, '2002-05-01');

/* Insert into Teacher Information */
INSERT INTO Teacher_Information VALUES ('T1', 'Mr Jones');
INSERT INTO Teacher_Information VALUES ('T2', 'Ms Parker');
INSERT INTO Teacher_Information VALUES ('T3', 'Mr Peters');
INSERT INTO Teacher_Information VALUES ('T4', 'Mrs Patel');
INSERT INTO Teacher_Information VALUES ('T5', 'Ms Daniels');

/* Insert into Course Information */
INSERT INTO Course_Information VALUES ('Computer Science', 'BCS', 'T1');
INSERT INTO Course_Information VALUES ('Maths', 'EdExcel', 'T2');
INSERT INTO Course_Information VALUES ('Physics', 'OCR', 'T3');
INSERT INTO Course_Information VALUES ('Biology', 'WJEC', 'T4');
INSERT INTO Course_Information VALUES ('Music', 'AQA', 'T5');

/* Insert into Student-Course Enrollment */
INSERT INTO Student_Course_Enrollment VALUES (1001, 'Computer Science');
INSERT INTO Student_Course_Enrollment VALUES (1001, 'Maths');
INSERT INTO Student_Course_Enrollment VALUES (1001, 'Physics');
INSERT INTO Student_Course_Enrollment VALUES (1002, 'Maths');
INSERT INTO Student_Course_Enrollment VALUES (1002, 'Biology');
INSERT INTO Student_Course_Enrollment VALUES (1002, 'Music');
INSERT INTO Student_Course_Enrollment VALUES (1003, 'Computer Science');
INSERT INTO Student_Course_Enrollment VALUES (1003, 'Maths');
INSERT INTO Student_Course_Enrollment VALUES (1003, 'Physics');
INSERT INTO Student_Course_Enrollment VALUES (1004, 'Maths');
INSERT INTO Student_Course_Enrollment VALUES (1004, 'Physics');
INSERT INTO Student_Course_Enrollment VALUES (1004, 'Biology');
INSERT INTO Student_Course_Enrollment VALUES (1005, 'Computer Science');
INSERT INTO Student_Course_Enrollment VALUES (1005, 'Maths');
INSERT INTO Student_Course_Enrollment VALUES (1005, 'Music');

/*--------------------------------------------------------------------*/

/* Testing Referential Integrity */

/* Test 1: Insert Invalid Data 
Try inserting a non-existent Student_Number into Student_Course_Enrollment to verify */
INSERT INTO Student_Course_Enrollment VALUES(9999, 'Maths');

/* Test 2: Delete Cascade/Restrict
Try deleting a Course_Name referenced in Student_Course_Enrollment to confirm foreign key constraints */
DELETE FROM Course_Information WHERE Course_Name = 'Maths';


/*--------------------------------------------------------------------*/

/* Query the Database */
/* Writing queries to verify relationships and retrieve data */

/* Example Query: List Courses for a Student */
SELECT s.Student_Name, c.Course_Name
FROM Student_Information s
JOIN Student_Course_Enrollment e ON s.Student_Number = e.Student_Number
JOIN Course_Information c ON e.Course_Name = c.Course_Name
WHERE s.Student_Name = 'Bob Baker';

/* Example Query: Find Students for a Teacher */
SELECT t.Teacher_Name, s.Student_Name, c.Course_Name
FROM Teacher_Information t
JOIN Course_Information c ON t.Teacher_ID = c.Teacher_ID
JOIN Student_Course_Enrollment e ON c.Course_Name = e.Course_Name
JOIN Student_Information s ON e.Student_Number = s.Student_Number
WHERE t.Teacher_Name = 'Ms Parker';




