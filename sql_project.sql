-- Create the tables and keys

CREATE TABLE students (
  student_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (student_id)
);

CREATE TABLE courses (
  course_id INT NOT NULL AUTO_INCREMENT,
  course_name VARCHAR(255) NOT NULL,
  department VARCHAR(255) NOT NULL,
  PRIMARY KEY (course_id)
);

CREATE TABLE professors (
  professor_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (professor_id)
);

CREATE TABLE grades (
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  professor_id INT NOT NULL,
  grade INT NOT NULL,
  PRIMARY KEY (student_id, course_id, professor_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id),
  FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

-- Populate tables

INSERT INTO students (first_name, last_name)
VALUES ('Alice', 'Smith'),
       ('Bob', 'Jones'),
       ('Charlie', 'Williams'),
       ('Dave', 'Brown'),
       ('Eve', 'Miller');

INSERT INTO courses (course_name, department)
VALUES ('Math 101', 'Mathematics'),
       ('English 101', 'English'),
       ('Computer Science 101', 'Computer Science'),
       ('History 101', 'History'),
       ('Biology 101', 'Biology');

INSERT INTO professors (first_name, last_name)
VALUES ('Dr. Johnson', 'Johnson'),
       ('Dr. Williams', 'Williams'),
       ('Dr. Brown', 'Brown'),
       ('Dr. Miller', 'Miller'),
       ('Dr. Smith', 'Smith');

INSERT INTO grades (student_id, course_id, professor_id, grade)
VALUES (1, 1, 1, 90),
       (1, 2, 2, 80),
       (1, 3, 3, 70),
       (1, 4, 4, 60),
       (1, 5, 5, 50),
       (2, 1, 1, 40),
       (2, 2, 2, 60),
       (2, 3, 3, 70),
       (2, 4, 4, 80),
       (2, 5, 5, 90),
       (3, 1, 1, 70),
       (3, 2, 2, 80),
       (3, 3, 3, 90),
       (3, 4, 4, 60),
       (3, 5, 5, 40),
       (4, 1, 1, 80),
       (4, 2, 2, 90),
       (4, 3, 3, 70),
       (4, 4, 4, 60),
       (4, 5, 5, 50),
       (5, 1, 1, 90),
       (5, 2, 2, 80),
       (5, 3, 3, 70),
       (5, 4, 4, 60),
       (5, 5, 5, 50);

-- Average Grade Given by proffesor
SELECT professor_id, AVG(grade) AS average_grade
FROM grades
GROUP BY professor_id;

-- Top Grades by Student
SELECT student_id, MAX(grade) AS top_grade
FROM grades
GROUP BY student_id;

-- Sort Students by Course
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students s
JOIN grades g ON s.student_id = g.student_id
JOIN courses c ON g.course_id = c.course_id
ORDER BY c.course_name;


-- Summary Report
SELECT c.course_id, c.course_name, AVG(grade) AS average_grade
FROM courses c
JOIN grades g ON c.course_id = g.course_id
GROUP BY c.course_id, c.course_name
ORDER BY average_grade;

-- Find student and proffesor courses in common
-- Note, With the example I had all of them coincide all the time so it's always "1". That's why it's limited to 1, because otherwise we get the whole list.
-- I do believe is correct though, I would, of course, appreciate any corrections.
SELECT student_id, professor_id, COUNT(*) AS num_courses
FROM grades
GROUP BY student_id, professor_id
ORDER BY num_courses DESC
LIMIT 1;

