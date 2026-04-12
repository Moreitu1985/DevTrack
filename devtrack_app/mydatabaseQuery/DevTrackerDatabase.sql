CREATE DATABASE devtrack;

USE devtrack;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  title VARCHAR(255),
  description TEXT,
  stage ENUM('Idea','Development','Testing','Completed'),
  support_needed TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO projects (user_id, title, description, stage, support_needed, visibility) VALUES
(1, 'DevTrack Platform', 'A build-in-public platform for developers to share projects, track progress, and collaborate.', 'Development', 'UI feedback and testing support', 'public'),

(2, 'Smart Budget App', 'A mobile budgeting app that helps students manage monthly expenses and savings.', 'Idea', 'Need help with database design', 'public'),

(3, 'Campus Navigation System', 'A web and mobile solution to help students find lecture halls, labs, and admin offices easily.', 'Testing', 'Bug testing and map integration support', 'public'),

(4, 'Aftercare Attendance Manager', 'A system for managing student attendance, parent pickup tracking, and notifications.', 'Completed', 'No support required', 'public'),

(5, 'AI Study Assistant', 'An assistant that suggests study schedules and quiz questions based on selected modules.', 'Development', 'Need help with AI recommendation logic', 'private'),

(1, 'Job Application Tracker', 'A dashboard for tracking internships, graduate programmes, deadlines, and application statuses.', 'Development', 'Support with dashboard charts', 'public'),

(2, 'Clinic Booking System', 'A booking platform for local clinics to manage patient appointments digitally.', 'Idea', 'Need backend API help', 'private'),

(3, 'Food Rescue Connect', 'A community platform that connects restaurants with charities to reduce food waste.', 'Testing', 'Need user testing feedback', 'public');

ALTER TABLE projects
ADD COLUMN visibility ENUM('public','private') NOT NULL DEFAULT 'public';


select * FROM users;
CREATE TABLE updates (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE comments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT,
  user_id INT,
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE collaboration_requests (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT,
  user_id INT,
  status ENUM('pending','accepted','rejected'),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);