create table departments(
	Primary Key (dept_no),
	Unique (dept_name),
	dept_no VARCHAR not NULL,
	dept_name VARCHAR not NULL
);

create table dept_emp(
	primary key (emp_no,dept_no),
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	emp_no Int not null,
	dept_no varchar not null,
	from_date date not null,
	to_date date not null
);

create table dept_manager(
	primary key (emp_no,dept_no),
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	dept_no varchar not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null
);

create table employees(
	primary key (emp_no),
	emp_no int not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	gender varchar not null,
	hire_date date not null
);

create table salaries(
	primary key (emp_no,from_date),
	foreign key (emp_no) references employees (emp_no),
	emp_no int not null,
	salary int not null,
	from_date date not null,
	to_date date not null
);

create table titles(
	primary key (emp_no,title,from_date),
	foreign key (emp_no) references employees (emp_no),
	emp_no int not null,
	title varchar not null,
	from_date date not null,
	to_date date not null
);


-- List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.emp_no, employees.last_name, employees.first_name,employees.gender,salaries.salary 
from employees
left join salaries on (employees.emp_no = salaries.emp_no) order by employees.emp_no;

--List employees who were hired in 1986.
select first_name, last_name from employees where hire_date between '1986-01-01' and '1986-12-31';

--List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
select dept_manager.dept_no, dept_manager.emp_no, dept_manager.from_date, dept_manager.to_date, departments.dept_name,
employees.first_name, employees.last_name from dept_manager
inner join departments on (dept_manager.dept_no = departments.dept_no)
inner join employees on (dept_manager.emp_no = employees.emp_no);

--List the department of each employee with the following information: employee number, last name, first name,
--and department name.
select employees.emp_no, employees.first_name, employees.last_name, departments.dept_name from employees
inner join dept_emp on (employees.emp_no = dept_emp.emp_no)
inner join departments on (dept_emp.dept_no = departments.dept_no)
order by employees.emp_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees where first_name = 'Hercules' and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select employees.emp_no, employees.first_name, employees.last_name, departments.dept_name from employees
inner join dept_emp on (employees.emp_no = dept_emp.emp_no)
inner join departments on (dept_emp.dept_no = departments.dept_no)
where departments.dept_name in ('Sales') order by employees.emp_no;

--List all employees in the Sales and Development departments, including their employee number, last name, first name,
--and department name.
select employees.emp_no, employees.first_name, employees.last_name, departments.dept_name from employees
inner join dept_emp on (employees.emp_no = dept_emp.emp_no)
inner join departments on (dept_emp.dept_no = departments.dept_no)
where departments.dept_name in ('Sales', 'Development') order by employees.emp_no;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) from employees group by last_name order by count(last_name) desc;


