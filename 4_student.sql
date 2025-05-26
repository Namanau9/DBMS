CREATE TABLE Teacher (
    TeacherID INT PRIMARY KEY,
    TeacherName VARCHAR(100)
);

CREATE TABLE Subject (
    SubjectCode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    CreditValue INT,
    ModuleLeader VARCHAR(100),
    Department VARCHAR(50),
    PrerequisiteCourse VARCHAR(100),
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID) ON DELETE CASCADE
);
CREATE TABLE Teaches (
    TeacherID INT,
    SubjectCode VARCHAR(10),
    PRIMARY KEY (TeacherID, SubjectCode),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
);

CREATE TABLE Student (
    SerialNumber INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200)
);

CREATE TABLE StudentProgress (
    SerialNumber INT,
    SubjectCode VARCHAR(10),
    FinalIA INT,
    PRIMARY KEY (SerialNumber, SubjectCode),
    FOREIGN KEY (SerialNumber) REFERENCES Student(SerialNumber),
    FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode)
);



INSERT INTO Teacher (TeacherID, TeacherName) VALUES (1, 'Dr. Smith');
INSERT INTO Teacher (TeacherID, TeacherName) VALUES (2, 'Prof. Johnson');
INSERT INTO Teacher (TeacherID, TeacherName) VALUES (3, 'Dr. Lee');

INSERT INTO Subject (SubjectCode, Title, CreditValue, ModuleLeader, Department, PrerequisiteCourse, TeacherID) 
VALUES ('CS101', 'Intro to CS', 4, 'Dr. Smith', 'Computer Science', NULL, 1);
INSERT INTO Subject (SubjectCode, Title, CreditValue, ModuleLeader, Department, PrerequisiteCourse, TeacherID) 
VALUES ('MATH101', 'Calculus I', 3, 'Prof. Johnson', 'Mathematics', NULL, 2);
INSERT INTO Subject (SubjectCode, Title, CreditValue, ModuleLeader, Department, PrerequisiteCourse, TeacherID) 
VALUES ('CS102', 'Data Structures', 4, 'Dr. Lee', 'Computer Science', 'CS101', 3);

INSERT INTO Teaches (TeacherID, SubjectCode) VALUES (1, 'CS101');
INSERT INTO Teaches (TeacherID, SubjectCode) VALUES (2, 'MATH101');
INSERT INTO Teaches (TeacherID, SubjectCode) VALUES (3, 'CS102');

INSERT INTO Student (SerialNumber, Name, Address) VALUES (101, 'Alice', '123 Maple St');
INSERT INTO Student (SerialNumber, Name, Address) VALUES (102, 'Bob', '456 Oak Ave');
INSERT INTO Student (SerialNumber, Name, Address) VALUES (103, 'Charlie', '789 Pine Rd');

INSERT INTO StudentProgress (SerialNumber, SubjectCode, FinalIA) VALUES (101, 'CS101', 85);
INSERT INTO StudentProgress (SerialNumber, SubjectCode, FinalIA) VALUES (102, 'MATH101', 90);
INSERT INTO StudentProgress (SerialNumber, SubjectCode, FinalIA) VALUES (103, 'CS102', 78);


-- b. Retrieve the Teacher names who are not Module leaders:
SELECT TeacherName
FROM Teacher
WHERE TeacherID NOT IN (
    SELECT DISTINCT TeacherID
    FROM Subject
);

-- c. Display the department which offers the subject “Database Management System”:
SELECT DISTINCT Department
FROM Subject
WHERE Title = 'Database Management System';

--d. Display the number of Subjects taught by each Teacher:
SELECT TeacherName, COUNT(*) AS NumberOfSubjects
FROM Teacher T, Teaches Tc
WHERE T.TeacherID = Tc.TeacherID
GROUP BY TeacherName;

--e. Categorize students based on their Subject Examination Marks:
SELECT S.SerialNumber, S.Name, SP.SubjectCode,
    CASE
        WHEN FinalIA BETWEEN 70 AND 100 THEN 'Outstanding'
        WHEN FinalIA BETWEEN 40 AND 69 THEN 'Average'
        ELSE 'Weak'
    END AS Category
FROM StudentProgress SP, Student S
WHERE SP.SerialNumber = S.SerialNumber;
