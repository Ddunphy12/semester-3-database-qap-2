-- Problem 1: University Course Enrollment

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    school_enrollment_date DATE
);

CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(100)
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT,
    professor_id INT REFERENCES professors(id) ON DELETE SET NULL

);

CREATE TABLE enrollments (
    student_id INT REFERENCES students(id),
    course_id INT REFERENCES courses(id),
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);


-- Thee Data
INSERT INTO students (first_name, last_name, email, school_enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-09-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-09-01'),
('Alice', 'Johnson', 'alice.johnson@example.com', '2022-08-20'),
('Bob', 'Brown', 'bob.brown@example.com', '2021-07-15'),
('Charlie', 'Davis', 'charlie.davis@example.com', '2024-01-10');

INSERT INTO professors (first_name, last_name, department) VALUES
('Dr. Emily', 'Clark', 'Physics'),
('Dr. Alan', 'Turing', 'Computer Science'),
('Dr. Marie', 'Curie', 'Chemistry'),
('Dr. Richard', 'Feynman', 'Mathematics');

INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Physics 101', 'Introductory Physics', 1),
('Computer Science 101', 'Basics of Computing', 2),
('Organic Chemistry', 'Introduction to Organic Chemistry', 3);

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-02-01'),
(2, 1, '2024-02-02'),
(3, 2, '2024-02-03'),
(4, 2, '2024-02-04'),
(5, 3, '2024-02-05');

-- Queries
SELECT first_name || ' ' || last_name AS full_name FROM students 
JOIN enrollments ON students.id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.id
WHERE courses.course_name = 'Physics 101';

SELECT courses.course_name, professors.first_name || ' ' || professors.last_name AS professor_name FROM courses -- Is this the best way of doing this?
JOIN professors ON courses.professor_id = professors.id;

SELECT DISTINCT courses.course_name FROM courses
JOIN enrollments ON courses.id = enrollments.course_id;

-- My single update
UPDATE students SET email = 'john.newemail@example.com' WHERE id = 1;

-- My single Delete
DELETE FROM enrollments WHERE student_id = 1 AND course_id = 1;
