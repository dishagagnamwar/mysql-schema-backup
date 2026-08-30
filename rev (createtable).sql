create database academyDb;
use academyDb;

create table courses (course_id int primary key auto_increment , coursename varchar(100) not null,
durations_month int );

create table learners (stud_id int primary key  , courseid int ,foreign key (courseid) references 
courses (course_id) on update cascade , enroll_date date not null);

create table enrollments (enroll_id int primary key auto_increment,
 student_id int , foreign key (student_id) references learners (stud_id));
 
select * from courses;

 insert into courses(course_id, coursename, durations_month)values
 (1, 'maths', 6),(2,'science',10),(3,'social',12);
 select* from courses;
 
insert into learners(stud_id, courseid, enroll_date)values
(101,1, '2026-05-1'),(102,2,'2024-01-11'),(103,3,'2025-09-29');
 
 select *from learners;
 
insert into enrollments(enroll_id, student_id)values
(1001, 101),(1002,102),(1003,103);
select * from enrollments;

delete from learners where stud_id=102;
alter table enrollments drop foreign key enrollment_ibfk_1;
 

update courses set course_id =4 where course_id=3;
select*from courses;

alter table enrollments add column status varchar(20) default 'active';
desc enrollments;

alter table enrollments modify column status add constraint check_status check('active','completed','dropped');




