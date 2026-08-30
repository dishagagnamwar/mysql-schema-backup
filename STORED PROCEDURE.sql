#stored procedure without parameer 
delimiter $$
create procedure cust_detail()
begin 
select customernumber, customername , city , state, country , creditlimit 
from customers;
end $$ 
delimiter ;

call cust_detail();

#stored procedure with multiple select 
delimiter $$
create procedure cust_order_orderdet_product()
begin
select * from customers;
select * from orders;
select * from orderdetails;
select * from products;
end $$
delimiter ;

call cust_order_orderdet_product();

delimiter $$ 
create procedure cust_det_usa()
begin 
select customernumber , customername, city , state , country , creditlimit 
from customers where country ="usa";
end $$
delimiter ;

call cust_det_usa;

#stored procedure with input parameter 
delimiter $$
create procedure cust_det_countrywise(in country varchar(100))
begin 
select customernumber, customername , city , state, c.country , creditlimit 
from customers c where c.country =country ;
end $$
delimiter ;

call cust_det_countrywise("germany");

#stored procedure with multiple input parameter 

delimiter $$
create procedure cust_det_cred(in country varchar(100) , in creditlimit decimal(10,2))
begin 
select customernumber , customername , city , state, c.country, c.creditlimit 
from customers c where c.country=country and c.creditlimit>creditlimit;
end $$
delimiter ;

call cust_det_cred("germany", 100000);

#wa stored procedure to fetch top n highest tov product of each productline 
#of each orderyear ? (input parameter - p_productline , o_year , d_rank) 

delimiter $$ 
create procedure top_n_product(in p_productline varchar(100), in o_year year ,
in d_rank int )
begin 
with cte as 
(select productline , productname , year(orderdate)as orderyear , 
sum(quantityordered*priceeach)as tov , 
dense_rank() over(partition by productline , year(orderdate) order by 
sum(quantityordered*priceeach) desc)as d_rn
from products inner join orderdetails using (productcode) inner join orders
using (ordernumber) group by 1,2,3 )
select * from cte where productline=p_productline and orderyear=o_year 
and d_rn<d_rank ;

end $$
delimiter ;


call top_n_product("vintage cars",2004 , 3);

#FIND_IN_SET
delimiter $$
create procedure customer_details_country (in c_country varchar(100))
begin 
select * from customers
where find_in_set(country, c_country);
end $$
delimiter ;

call customer_details_country("usa, japan, germany, austria");


#STORED PROCEDURE WITH SINGLE OUT PARAMETER
delimiter $$
create procedure cust_ordercount(in cnumber int , out ordercount int)
begin 
select count(ordernumber)into ordercount from customers 
inner join orders using(customernumber) 
where customernumber=cnumber;
end $$ 
delimiter ;

call cust_ordercount (141 , @ordercount);
select if(@ordercount =1 , "one time",
         if (@ordercount =2, "repeated",
         if (@ordercount = 3, "frequent", "loyal" ))) as customer_type;
         
         
delimiter $$
create procedure productline_type (in p_productline varchar(100),
out tov decimal (10,2) ,out tqo int )
begin 
select sum(quantityordered), sum(quantityordered*priceeach) into tqo , tov from 
products inner join orderdetails using(productcode)
where productline=p_productline;
end $$
delimiter ;

call productline_type("classic cars" , @tov , @tqo );
select @tov , @tqo;



#wa stored procedure that accepts a productcode and return 
#productname , buyprice , quantity_in_stock 
#3 parameters (input = p_productcode), (out= p_productname , p_buyprice, p_quantity )

delimiter $$
create procedure product_detail (in p_productcode varchar(100), out p_productname varchar(100)
 , out p_buyprice decimal(10,2), out p_quantity int)
begin 
select productname , buyprice , quantityinstock into
p_productname , p_buyprice, p_quantity from products 
where productcode=p_productcode;
end $$
delimiter ;

call product_detail("s10_1678" , @name,@price,@quantity);
select @name , @price , @quantity;


#wa stored procedure that accept an employeenumber and return empname , 
#jobtitle , officecode and the customer they handle 
#(input = empnumber ) (out = e_name, e_jobtitle , e_officecode, cust_count ) 

delimiter $$
create procedure empdetails (in empnumber int , out e_name varchar (100),
out e_jobtitle varchar(100) , out e_officecode varchar(100) ,out cust_count int)
select employeenumber , 















