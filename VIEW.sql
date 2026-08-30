#VIEW is a virtual table that store query instead of data 
#syntax
#create view viewname as 
#select query ;

#create view 
create view cust_details as 
select customernumber, customername , city , state , country , creditlimit 
from customers;

select * from cust_details; 

#create view from another view 
create view cust_details_usa as 
select customernumber , customername, city , state , country 
from cust_details where country= "usa";

select * from cust_details_usa;

#join two views 
select * from cust_details cross join cust_details_usa;

select * from customers cross join cust_details ;

#create view with custom colname 
create view product_det(p_category, p_name , bprice, msrp)as 
select productline , productname, buyprice, msrp from products;

select * from product_det ;

#updatable view 
create algorithm= undefined view customer_det as 
select customernumber, customername , city , state, country from customers;

update customer_det set customername="decode"
where customernumber=103;

select * from customer_det;
select * from customers;

#non updatable view 

create algorithm=temptable view order_det as 
select ordernumber, orderdate , shippeddate , status from orders;

select * from order_det;

update order_det set orderdate="2026-01-10"
where ordernumber=10100;
#(non updatable!!!!)


#rename view
#rename table tablename to tablename 

rename table product_det to pro_det;

select * from pro_det;

#drop view
drop view cust_details_usa;

show full tables;

create view cust_ordercount as 
select customername, count(ordernumber)as ordercount from customers 
inner join orders using(customernumber)
group by customername ;


select *from cust_ordercount;
















