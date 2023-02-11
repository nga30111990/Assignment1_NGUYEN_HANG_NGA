CREATE DATABASE IF NOT EXISTS assignment1;

USE assignment1;

/* create table */

CREATE TABLE department (
department_id   TINYINT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE `position`  (
position_id   TINYINT PRIMARY KEY AUTO_INCREMENT,
position_name ENUM("dev", "test", "scrum_master", "pm")
);

CREATE TABLE `account` (
account_id    INT PRIMARY KEY AUTO_INCREMENT,
email         VARCHAR(50) NOT NULL UNIQUE,
user_name     VARCHAR(50) NOT NULL UNIQUE,
full_name     VARCHAR(100),
department_id TINYINT, 
-- CONSTRAINT FOREIGN KEY(department_id) REFERENCES 1department(department_id),
CONSTRAINT account_department_fk FOREIGN KEY(department_id) REFERENCES department(department_id),
CONSTRAINT account_position_fk FOREIGN KEY(position_id) REFERENCES `position`(position_id),
position_id   TINYINT,
create_date    DATE 
);

CREATE TABLE `group` (
group_id      TINYINT PRIMARY KEY AUTO_INCREMENT,
group_name    VARCHAR(100) NOT NULL UNIQUE,
creator_id    INT,
create_date   DATE NOT NULL
);

CREATE TABLE group_account (
group_id     TINYINT,
CONSTRAINT GA_group_fk FOREIGN KEY(group_id) REFERENCES `group`(group_id),
account_id   INT,
CONSTRAINT GA_account_fk FOREIGN KEY(account_id) REFERENCES `account`(account_id),
join_date    DATE NOT NULL
);

CREATE TABLE type_question (
type_id      INT PRIMARY KEY AUTO_INCREMENT,
type_name    ENUM("essay", "multiple_choice")
);

CREATE TABLE category_question (
category_id   INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE question (
question_id   INT PRIMARY KEY AUTO_INCREMENT,
content       VARCHAR(200) NOT NULL,
category_id   INT,
CONSTRAINT CQ_question_fk FOREIGN KEY(category_id) REFERENCES category_question(category_id),
type_id       INT,
CONSTRAINT TQ_question_fk FOREIGN KEY(type_id) REFERENCES type_question(type_id),
creator_id    INT NOT NULL,
create_date   DATE NOT NULL
);

CREATE TABLE answer (
answer_id     INT PRIMARY KEY AUTO_INCREMENT,
content       VARCHAR(200) NOT NULL,
question_id   INT,
CONSTRAINT question_answer_fk FOREIGN KEY(question_id) REFERENCES question(question_id),
iscorrect     ENUM("yes", "no")
);

CREATE TABLE vti_exam (
exam_id       INT PRIMARY KEY AUTO_INCREMENT,
code_exam     CHAR(10) NOT NULL UNIQUE,
title         VARCHAR(50) NOT NULL,
category_id   INT,
CONSTRAINT CQ_VE_fk FOREIGN KEY(category_id) REFERENCES category_question(category_id),
duration      TIME NOT NULL,
creator_id    INT NOT NULL,
create_date   DATE NOT NULL
);

CREATE TABLE vti_exam_question (
exam_id       INT,
CONSTRAINT VE_VEQ_fk FOREIGN KEY(exam_id) REFERENCES vti_exam(exam_id),
question_id   INT NOT NULL
);
