use University;

select * from student;

--- find the students belonging to same department; run both the queries to see the difference

select A.name, B.name, A.dept_name
from student A, student B
where A.dept_name = B.dept_name and A.name < B.Name;

