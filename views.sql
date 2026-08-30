#views

#views is vertual table genrated from the resul set of predefined select query it looks and act like a 
#real table / base table with row and column but it does note store data phycialy in the databse 
#(views stored query it dynamicaaly pulls /fetch real time data from the base table every time 
#it is quesried

#uses of views

#simplify query hide complex quesry bheind a simple table name
#enhance sequrity restrict acces(to sensitive data by revailing only specific row and column to a certain user

# syntax
# create view viewname as
# select query;

# create basic view
create view cust_details as
select customernumber,customername,city,state,country,creditlimit
from customers;

select * from cust_details;

# create view from another view
create view cust_details_usa as
select customernumber,customername,creditlimit from cust_details
where country="usa";

select * from cust_details_usa;

# join two views
select * from cust_details cross join cust_details_usa;

# join view with a base table

select customername,count(ordernumber) as ordercount from 
cust_details inner join orders using(customernumber) group by customername;

# create view with a custom column
create view product_det(pline,pname,pcode,msrp,bprice) as
select productline,productname,productcode,msrp,buyprice
from products;

select * from product_det;

# create updatable view
create algorithm=undefined view cust_det as
select customernumber,customername,city,state,country
from customers;

select * from cust_det;

update cust_det set customername="dda"
where customernumber=103;

select * from cust_det;
select * from customers;

# non updatable view
create algorithm = temptable view order_det as
select ordernumber,orderdate,status from orders;

select * from order_det;

update order_det set status="cancelled"
where ordernumber=10100;

show full tables;

# rename view
# rename table tableoldname to tablenewname;

rename table cust_det to customers_details_1;

# drop 
# drop view viewname;

drop view customers_details_1;

create view productline_tov as
select productline,year(orderdate) as orderyear,
sum(quantityordered*priceeach) as tov from products
inner join orderdetails using(productcode)
inner join orders using(ordernumber)
group by 1,2;
