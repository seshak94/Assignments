module-4

use module

select * from customer
select * from orders

--1. Use the inbuilt functions and find the minimum, maximum and average
-- amount from the orders table

select max(amount) max_amount,min(amount) min_amount,avg(amount) avg_amount from orders


-- 2. Create a user-defined function which will multiply the given number with 10

create or alter function fn_multiply_by_10(@input int)
returns int
as
begin

return @input * 10

end

select amount,dbo.fn_multiply_by_10(amount) from ORDERS



select dbo.fn_multiply_by_10(20) as multiply_by_10


-- 3. Use the case statement to check if 100 is less than 200, greater than 200
-- or equal to 200 and print the corresponding value.

select 
case

when 100=200 then'100 is equlat to 200'
when 100>200 then '100 is greater than 200'
when 100<200 then '100 is less than 200'
end
----------------------------------
select 
case

when 100=200 then'100 is equlat to 200'
when 100>200 then '100 is greater than 200'
else '100 is less than 200'
end


-- 4. Using a case statement, find the status of the amount. Set the status of the
-- amount as high amount, low amount or medium amount based upon the
-- condition.

select * from ORDERS

select amount,case when amount >=3000 then 'high'
when amount >= 1500 then 'medium'
else 'low'
end
from orders


-- 5. Create a user-defined function, to fetch the amount greater than then given
-- input.

select * from orders

select * from orders
where amount>500


create function fn_getbyamount(@input int)
returns table
as
return
(
select * from orders
where amount>@input
)

select order_id from dbo.fn_getbyamount(200)


--module-5

 --1. Arrange the ‘Orders’ dataset in decreasing order of amount

 select * from orders order by amount desc


 --2. Create a table with the name ‘Employee_details1’ consisting of these
 --columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’.
 
 --Create another table with
 --the name ‘Employee_details2’ consisting of the same columns as the first
 --table.


 create table emp_details1
 (
  emp_id int,
  emp_name varchar(100),
  emp_salary int
 )
 insert into emp_details1 values(1,'suraj',100)
 select * from emp_details1
 select * into emplo2 from emp_details1

 select * from emplo2




 --3. Apply the UNION operator on these two tables

 union-> used to combine two result set or two select statement
 -> remove duplicates from combined result set

select * from employee_Details2
union 
select * from employee_details1


select emp_id from employee_Details2
union all
select emp_id from employee_details1


 --4. Apply the INTERSECT operator on these two tables

 select * from employee_Details2
intersect
select * from employee_details1


 --5. Apply the EXCEPT operator on these two tables
select * from employee_Details2
except
select * from employee_details1

select * from orders


--datename->weekday,day,month,year,quarter-> string format
--datepart->weekday,day,month,year,quarter-> int format
--select datename(weekday,order_date) as day ,sum(amount) from ORDERS
--group by datename(weekday,order_date)

--select datename(quarter,order_date) as day ,sum(amount) from ORDERS
--group by datename(quarter,order_date)


--module 6


--1. Create a view named ‘customer_san_jose’ which comprises of only those
-- customers who are from San Jose

select * from customer
where city='san jose'


create view vw_customer_from_sanjose
as
select * from customer
where city='san jose'

select * from vw_customer_from_sanjose

-- 2. Inside a transaction, update the first name of the customer to Francis
-- where the last name is Smith:
-- a. Rollback the transaction
-- b. Set the first name of customer to Alex, where the last name is
-- Smith

select * from customer

begin transaction

update customer
set first_name='francis'
where last_name='smith'

rollback

begin transaction
update customer
set first_name='Alex'
where last_name='smith'
commit

-- 3. Inside a TRY... CATCH block, divide 100 with 0, print the default error
-- message.


begin try
select 100/0
end try
begin catch
print('divided by zero')
end catch

select * from ORDERS

-- 4. Create a transaction to insert a new record to Orders table and save it.

begin transaction
insert into ORDERS values(115,'2024-03-02',2345,1)
commit





