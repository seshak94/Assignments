Create database feb25
use feb25

Create table customer ( Customer_ID int, [First Name] varchar(20), [Last Name] varchar (20), email varchar(30), [Address] varchar (40), city varchar(20), [state] varchar (30), zip int )
select * from customer
INSERT INTO customer (Customer_ID,[First Name] , [Last Name],email,[Address],city,[state],zip) 
VALUES (1, 'kumar', 'A', 'KA@Gmail.com', 'South India', 'Bengaluru', 'karantaka','560401'),
(2,'Shujan','Chakraborty','SC@xyz.com','Nort East India','Guhati','Assam','570601'),
(3,'Ritu','M','RM@xyz.com','North America','LA','California','570602'),
(4,'Sayan','Chandra','SC@Gmail.com','North America','Las_Vegas','Nevada','570603'),
(5,'Gita','Lao','GL@xyz.com','North America','San_Jose','California','570604')

select [First Name ], [Last Name] from customer

select * from customer where [First Name] like 'G%' and city = 'San_Jose'
select * from customer where email like '%Gmail%'
select * from customer where [LAst Name] not  like '%G'








create table Orders (order_ID int, order_date date, amount int, customer_id int)
select * from orders 

insert into Orders (order_ID , order_date , amount , customer_id )
values ('100','2022-07-23','20000','1'),
('102','2023-04-15','20000','3'),
('103','2022-11-14','45000','6'),
('104','2023-07-23','12000','5'),
('105','2021-09-26','34600','2'),
('106','2019-10-21','34600','9')



select * from customer
Join orders 
on customer.Customer_ID = Orders.customer_id


select * from customer
Left Join orders 
on customer.Customer_ID = Orders.customer_id

select * from customer
Right Join orders 
on customer.Customer_ID = Orders.customer_id

select * from customer
Full Join orders 
on customer.Customer_ID = Orders.customer_id


update orders
Set Amount=100
where customer_id=3


select t.* from orders t 
join orders y
on t.order_ID<>y.order_ID
and t.amount=y.amount

---t and y is reference points to compare value on same table values


select min(amount) as min_amount , max(amount) as max_amount, avg(amount) as avg_amount from orders 


create or alter function multiply(@input int)
returns int
as 
begin  ---scalar value function uses begin and end  , calculation allowed in scalar valued fn

return(@input*10)

end

select dbo.multiply(20) as multiplied_output


-----diff between function and store procedure

---confirmed data returns in functions not in store procedure and in function we ccan apply select querry



select
case
when 100=200 then '100 is qual to 200'
when 100>200 then '100 is greater than 200'
when 100<200 then '100 is less than 200'
end
---else  '100 is less than 200'


select * from orders

select amount,case when amount>=3000 then 'high'
when amount>=1500 then 'medium'
else 'low'
end
from orders



select * from orders order by amount desc


create function greaterthanamount(@input int)
returns table --table value function as fetching/comparing with table, we can use begin and end in table valued function
as 
return
(
select * from orders
where amount > @input 
)


select * from  dbo.greaterthanamount(1000) 



create table employee3
(
employeeName varchar(1000), employeeID int, employeeSalary int
)

insert into employee3 values( ' sesha', 1587, 100000)

select * from employee3

select * into employee4 from employee3

select * from employee4


-----union used to combine two result set or two select statement and it will removed duplicates from combine result set , data types should be same(apply ALL keyword if we want duplicate value as well)
---INTERSECT operator
---except operator

datename->weekday, day,month, quarter-->string format
datepart->weekday, day,month, quarter-->int format

select datename(weekday,order_date) as day ,sum(amount) from orders
group by datename(weekday,order_date)


select datename(quarter,order_date) as day ,sum(amount) from orders
group by datename(quarter,order_date)


create view sanjosecustomer
as
select * from customer where city = 'San_Jose'\

select * from sanjosecustomer




begin transaction
update customer
set First_Name= 'raju'
where Last_Name= 'A'

rollback

begin transaction
update customer
set First_Name= 'AJAY'
where Last_Name= 'A'

commit
