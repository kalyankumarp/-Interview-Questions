use University;

select * from student;

--- find the students belonging to same department; run both the queries to see the difference

select A.name, B.name, A.dept_name
from student A, student B
where A.ID <> B.ID and A.dept_name = B.dept_name
order by A.dept_name;

select A.name, B.name, A.dept_name
from student A, student B
where A.ID < B.ID and A.dept_name = B.dept_name
order by A.dept_name;


--- any

select avg(salary) from instructor group by dept_name;
select name, salary
from instructor 
where salary > any(select avg(salary) from instructor group by dept_name);

--- All

select name, salary
from instructor 
where salary > all(select avg(salary) from instructor group by dept_name);


------ MySQL String Functions
--- Concat
SELECT CONCAT("SQL ", "Tutorial ", "is ", "fun!") AS ConcatenatedString; 

--- Length of string in Bytes
SELECT LENGTH("SQL") AS LengthOfString;

--- Left
SELECT LEFT("SQL Tutorial", 3) AS ExtractString; 

--- Right
SELECT Right("SQL Tutorial", 3) AS ExtractString; 

--- Repeat
SELECT REPEAT("SQL Tutorial  ", 3); 

--- POSITION
SELECT POSITION('3' IN 'W3Schools.com') AS MatchPosition; 

--- Replace
SELECT REPLACE("SQL Tutorial", "SQL", "HTML"); 

--- Reverse
SELECT REVERSE("SQL Tutorial"); 

--- LTrim
SELECT LTRIM("         SQL Tutorial     ") AS L; 

--- RTRIM
SELECT RTRIM("         SQL Tutorial     ") AS R; 

--- Substring
SELECT SUBSTRING("SQL Tutorial", 1, 3) AS ExtractString; 


------ MySQL numeric Functions
--- ABSolute value
SELECT ABS(-243.5); 

--- Ceiling
SELECT CEILING(25.75); 

--- Exponential function
SELECT EXP(1);

--- Floor
SELECT FLOOR(25.75); 

--- Modulus or Remainder
SELECT MOD(18, 4); 

--- Round
SELECT ROUND(135.375, 2); 

--- Square root
SELECT SQRT(64); 

--- truncates a number to the specified number of decimal places.
SELECT TRUNCATE(135.375, 2); 

-------- MySQL Date Functions
--- Add years/months/days/hrs/minutes
SELECT ADDDATE("2017-06-15", INTERVAL 10 DAY) Newdate;

SELECT ADDDATE("2017-06-15 09:34:21", INTERVAL 15 MINUTE) Newdate;

SELECT ADDDATE("2017-06-15 09:34:21", INTERVAL -3 HOUR) Newdate;

SELECT ADDDATE("2017-06-15", INTERVAL -2 MONTH) Newdate; 

SELECT ADDDATE("2017-06-15", INTERVAL -2 year) Newdate; 

--- Date difference - number of days between two dates; ignores the time of the dates considers only date
SELECT DATEDIFF("2017-06-25", "2017-06-15");

SELECT DATEDIFF("2017-06-25 09:34:21", "2017-06-15 15:25:35"); 

--- Extract year/month/day/hr/minute from a date
SELECT EXTRACT(MONTH FROM "2017-06-15"); 

-------- MySQL Advanced Functions
--- CAST/ convert - convert a column to a data type
SELECT CAST("2017-08-29" AS DATE); 

SELECT CAST("14:06:10" AS TIME);

--- Case in select
SELECT name, Salary,
CASE
    WHEN Salary > 60000 THEN "The Salary is greater than 60000"
    WHEN Salary = 60000 THEN "The Salary is 60000"
    ELSE "The Salary is under 60000"
END as Salary_Text
FROM instructor;

--- Case in order by
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);

SELECT name, Salary
FROM instructor
ORDER BY
CASE WHEN Salary > 60000 THEN Salary end desc,
CASE WHEN Salary < 60000 THEN name end asc;

--- ifnull
SELECT IFNULL(NULL, "W3Schools.com") n; 

SELECT IFNULL('Kal', "W3Schools.com") n; 


-------- case statement in Update

update instructor
set salary = case 
WHEN salary > 50000 then salary * 1.5
else salary * 1.3
end;

update instructor
set salary = case 
WHEN salary > 50000 then salary / 1.5
else salary / 1.3
end;

select name, salary from instructor;

------ Exists
--- find courses offered in both fall 2009 and spring 2010
select * from section;
select course_id from section A
where semester = "Fall" and year = 2009 and
exists (select * from section B where semester = "Spring" and year = 2010 and B.course_id = A.course_id);

select course_id from section A
where semester = "Fall" and year = 2009 and
not exists (select * from section B where semester = "Spring" and year = 2010 and B.course_id = A.course_id);


------ Rank
select dept_name, salary, Rank() over (partition by dept_name order by salary desc)
 from instructor;
 
 select *
 from (select dept_name, salary, Rank() over ( partition by dept_name order by salary desc) as R from instructor) A 
 where R= 1;


------ Pivot table

select * from section;
select year, semester, count(*)
from section group by year, semester order by year, semester;

select distinct year, (select count(*) from section A where A.year = s.year and A.semester = 'Fall') Fall,
	(select count(*) from section A where A.year = s.year and A.semester = 'Spring') Spring,
    (select count(*) from section A where A.year = s.year and A.semester = 'Summer') Summer
from section s;

------- Hackerrank Occupations problem

select distinct(dept_name) from instructor;
--- subquery
set @r1=0, @r2=0, @r3=0, @r4=0,@r5=0, @r6=0, @r7=0;
  select case when dept_name='Physics' then (@r1:=@r1+1)
            when dept_name='Music' then (@r2:=@r2+1)
            when dept_name='History' then (@r3:=@r3+1)
            when dept_name='Finance' then (@r4:=@r4+1)
            when dept_name='Elec. Eng.' then (@r5:=@r5+1)
            when dept_name='Biology' then (@r6:=@r6+1)
            when dept_name='Comp. Sci.' then (@r7:=@r7+1) end as RowNumber,
    case when dept_name='Physics' then Name end as Physics,
    case when dept_name='Music' then Name end as Music,
    case when dept_name='History' then Name end as History,
    case when dept_name='Finance' then Name end as Finance,
    case when dept_name='Elec. Eng.' then Name end as Electrical,
    case when dept_name='Biology' then Name end as Biology,
    case when dept_name='Comp. Sci.' then Name end as Computer
  from instructor order by name;
  
--- Main Query
set @r1=0, @r2=0, @r3=0, @r4=0,@r5=0, @r6=0, @r7=0;
select coalesce(min(Physics),' ') Physics, coalesce(min(Music),' ') Physics, coalesce(min(History),' ') History, 
		coalesce(min(Finance),' ') Finance, coalesce(min(Electrical),' ') Electrical, coalesce(min(Biology),' ') Biology, coalesce(min(Computer),' ') Computer
from(
  select case when dept_name='Physics' then (@r1:=@r1+1)
            when dept_name='Music' then (@r2:=@r2+1)
            when dept_name='History' then (@r3:=@r3+1)
            when dept_name='Finance' then (@r4:=@r4+1)
            when dept_name='Elec. Eng.' then (@r5:=@r5+1)
            when dept_name='Biology' then (@r6:=@r6+1)
            when dept_name='Comp. Sci.' then (@r7:=@r7+1) end as RowNumber,
    case when dept_name='Physics' then Name end as Physics,
    case when dept_name='Music' then Name end as Music,
    case when dept_name='History' then Name end as History,
    case when dept_name='Finance' then Name end as Finance,
    case when dept_name='Elec. Eng.' then Name end as Electrical,
    case when dept_name='Biology' then Name end as Biology,
    case when dept_name='Comp. Sci.' then Name end as Computer
  from instructor
  order by name
) Temp
group by RowNumber;



-- select A.year, A.semester, B.semester, A.c

-- from (select year, semester, count(*) c from section group by year, semester order by year, semester) A,
-- (select year, semester from section group by year, semester order by year, semester) B

-- where A.year = B.year and A.semester <> B.semester;


------- Subqueries
--- find names of instructors with salary greater than that of atleast one instructor in Biology department
select name from instructor A
where A.salary > any(select salary from instructor where dept_name = 'Biology');

--- find departments with average salary greater than the total salary of atleast one department
select dept_name, avg(salary) AVG_salary, sum(salary) SUM_salary from instructor group by dept_name;
select sum(salary) SUM_salary from instructor group by dept_name;

select A.dept_name
from (select dept_name, avg(salary) AVG_salary from instructor group by dept_name) A
where AVG_salary > any(select sum(salary) SUM_salary from instructor group by dept_name);


--- in From

select truncate(A.avs, 2)
from (select avg(salary) avs from instructor group by dept_name) A
where A.avs > 42000;

 --- in select
 
select dept_name, (select count(*) from instructor i where i.dept_name = d.dept_name) n
from department d
order by n desc;


---- group by followed by order by

select * from instructor;

select dept_name, name from instructor group by dept_name, name;

select dept_name, name from instructor order by dept_name, ID;
select dept_name, name from instructor group by dept_name, name order by dept_name, ID;


---- two people who took most of the courses
The following query does not work; check the query below it
-- use university;
-- select * from takes;

-- select (select name from student where ID = T.fp) first_person,
--  (select name from student where ID = T.sp) second_person,
--  (select title from course where course_id = T.course) title
-- from (select a.ID fp, b.ID sp, a.course_id course, rank() over (order by count(*) desc) r
-- from takes a, takes b
-- where a.course_id = b.course_id and a.ID < b.ID
-- group by fp, sp, course) T
-- where r =1;


---- Sample data for the above question

drop database if exists organization;
create database organization;

use organization;

create table person
(
  person_id int,
  first_name nvarchar(10),
  last_name nvarchar(10)
);    
insert into person (person_id, first_name, last_name) values
(1, 'Alice', 'A'),
(2, 'Bob', 'B'),
(3, 'Charlie', 'C'),
(4, 'David', 'D'),
(5, 'Eric', 'E');

create table meeting
(
  meeting_id int,
  title nvarchar(30)
);    
insert into meeting (meeting_id, title) values
(100, 'Corporate training'),
(200, 'Weekly sales'),
(300, 'Welcome introduction'),
(400, 'Evaluation');

create table participant
(
  meeting_id int,
  person_id int
);    
insert into participant (meeting_id, person_id) values
(100,1), (100,2), (100,3),
(200,1), (200,2),
(300,3), (300,4),
(400,3), (400,5),
(500,1), (500,5);

select * from participant;
--- subquery

select a.person_id fp, b.person_id sp, a.meeting_id
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id;

select a.person_id fp, b.person_id sp, rank() over (order by count(*) desc) r
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id
group by fp, sp;

select fp,sp
--  (select title from meeting where meeting_id = T.meeting) title
from (select a.person_id fp, b.person_id sp, rank() over (order by count(*) desc) r
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id
group by fp, sp) T
where r =1;

select A.fp, B.fp, A.meeting_id from
(select a.person_id fp, b.person_id sp, a.meeting_id
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id) A,
(select fp,sp
--  (select title from meeting where meeting_id = T.meeting) title
from (select a.person_id fp, b.person_id sp, rank() over (order by count(*) desc) r
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id
group by fp, sp) T
where r =1) B

where A.fp = B.fp and A.sp = B.sp;

--- main query

select (select concat (first_name, ' ', last_name) from person where person_id = A.fp) first_person,
 (select concat (first_name, ' ', last_name) from person where person_id = B.sp) second_person,
 (select title from meeting where meeting_id = a.meeting_id) title
from
(select a.person_id fp, b.person_id sp, a.meeting_id
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id) A,
(select fp,sp
--  (select title from meeting where meeting_id = T.meeting) title
from (select a.person_id fp, b.person_id sp, rank() over (order by count(*) desc) r
from participant a, participant b
where a.meeting_id = b.meeting_id and a.person_id < b.person_id
group by fp, sp) T
where r =1) B

where A.fp = B.fp and A.sp = B.sp
order by title;

-- select (select concat (first_name, ' ', last_name) from person where person_id = T.fp) first_person,
--  (select concat (first_name, ' ', last_name) from person where person_id = T.sp) second_person,
-- --  (select title from meeting where meeting_id = T.meeting) title
-- from (select a.person_id fp, b.person_id sp, a.meeting_id meeting, rank() over (order by count(*) desc) r
-- from participant a, participant b
-- where a.meeting_id = b.meeting_id and a.person_id < b.person_id
-- group by fp, sp, meeting) T
-- where r =1;

