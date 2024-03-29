create database casestudy
use casestudy

select  * from fact

select * from location

select * from product


 --Dataset:
 --The 3 key datasets for this case study:
 --a. FactTable: The Fact Table has 14 columns mentioned below and 4200
 --rows. Date, ProductID, Profit, Sales, Margin, COGS, Total Expenses,
 --Marketing, Inventory, Budget Profit, Budget COGS, Budget Margin, Budget
 --Sales, and Area Code
 --Note: COGS stands for Cost of Goods Sold
 --b. ProductTable: The ProductTable has four columns named Product Type,
 --Product, ProductID, and Type. It has 13 rows which can be broken down
 --into further details to retrieve the information mentioned in theFactTable.
 --c. LocationTable: Finaly, the LocationTable has 156 rows and follows a
 --similar approach to ProductTable. It has four columns named Area Code,
 --State, Market, and Market Size


 --1. Display the number of states present in theLocationTable.

 select count(distinct state) as total_state from location


 --2. Howmany products are of regular type?

 select count(type) as regular_type from product
 where type='regular'


 select * from product

 --3. Howmuch spending has been done on marketing of product ID 1?

select * from fact

select sum(marketing) as total_marketing_expense from fact
where productid=1

 --4. What is the minimum sales of a products?

 select min(sales) as min_sales from fact

 --5. Display the max Cost of Good Sold (COGS).

 select max(cogs) as max_cogs from fact

 --6. Display the details of the product where product type is coffee.

 select * from product 
 where product_type='coffee'


 --7. Display the details where total expenses are greater than40.

 select * from fact where Total_Expenses>40


 --8. What is the average sales in area code 719?

 select avg(sales) as avg_sales from fact where Area_Code=719

  select avg(sales) avg_sales from fact where Area_Code=719

 --9. Find out the total profit generated by Colorado state.

 select sum(profit) as total_profit from fact f inner join location l
 on f.Area_Code=l.area_code
 where state='colorado'



 --10 Display the average inventory for each product ID.

 select productid ,avg(inventory) as avg_inv from fact
 group by ProductId
 order by ProductId


 --11 Display state in a sequential order in a LocationTable.

 select distinct state from location 
 order by state
 

 --12 Display the average budget margin of the Product where the average budget
 --margin should be greater than 100.

 select productid, avg(budget_margin) as avg_budget_margin from fact
 group by productid
 having avg(budget_margin)>100
 order by ProductId asc


 --13 What is the total sales done on date 2010-01-01?

 select sum(sales) as total_sales from fact
 where date='2010-01-01'


 --14 Display the average total expense of each product ID on an individual date.

 select date,productid,avg(total_Expenses) as avg_expenses from fact
 group by date,ProductId
 order by date,ProductId



 --15 Display the table with the following attributes such as date, productID,
 --product_type, product, sales, profit, state, area_code.

 select f.Date,f.ProductId,p.product_type,p.product,f.Sales
 ,f.Profit,l.state,f.Area_Code from fact f inner join location l
 on f.Area_Code=l.area_code inner join
 product p on f.ProductId=p.productid


 --16 Display the rank without any gap to show the sales wiserank.

 select sales,DENSE_RANK() over (order by sales desc) as rank from fact


 --17 Find the state wise profit and sales.

 select state,sum(profit) as profit,sum(sales) as sales from fact f
 inner join location l
 on f.Area_Code=l.area_code
 group by state
 order by state 




 --18 Find the state wise profit and sales along with the productname.

  select state,Product,sum(profit) as profit,sum(sales) as sales from fact f
 inner join location l
 on f.Area_Code=l.area_code
 inner join product p
 on f.ProductId=p.productid
 group by state,product
 order by state,Product



 --19 If there is an increase in sales of 5%, calculate the increasedsales.

 select sales,sales *.05,sales *1.05 as inc_Sales from fact


 --20Find the maximum profit along with the product ID and producttype.

 select f.ProductId,Product_type,max(Profit) as profit from fact f
 inner join product p
 on f.ProductId=p.productid
 group by f.ProductId,Product_type

 --21 Create a stored procedure to fetch the result according to theproduct type
 --from ProductTable.

 select * from product
 where product_type='coffee'


 create procedure sp_getbytype(@input varchar(30))
 as
 begin

select * from product
 where product_type=@input

 end


 exec sp_getbytype 'tea'


 --22 Write a query by creating a condition in which if the total expenses is less than
 --60 then it is a profit or else loss.

 select total_Expenses,iif(total_expenses<60,'profit','loss') as status from fact


 select total_Expenses,case when Total_Expenses<60 then 'profit' 
 else 'loss' end as status 
 from fact



 --23Give the total weekly sales value with the date and product ID details. Use
 --roll-up to pull the data in hierarchical order.


 select datepart(week,date) as week,productid,sum(sales) as weekly_sales from fact
 group by datepart(week,date),ProductId with rollup



 --24 Apply union and intersection operator on the tables which consist of
 --attribute area code.

 select area_code from fact
 intersect
 select area_code from location

 select area_code from fact
 union
 select area_code from location

 --25 Create a user-defined function for the product table to fetch aparticular
 --product type based upon the user�s preference.

 select * from product
 where product_type='tea'

 

 create function fn_getbytype(@input varchar(20))
 returns table
 as
 return( select * from product
 where product_type=@input
 )


 select * from dbo.fn_getbytype('tea')




 --Change the product type from coffee to tea where product ID is 1 and undo
 --it.

 begin transaction

 update product
 set product_type='Tea'
 where productid=1

 rollback


 select * from product

 --Display the date, product ID and sales where total expensesare
 --between 100 to 200.
 --Delete the records in the Product Table for regulartype.

 --Display the ASCII value of the fifth character from the column Product.



 select ascii(substring(product,5,1)) from product
