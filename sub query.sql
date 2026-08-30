#WASQ to fetch customerno , check no , amount who paid the max amount
select customernumber, checknumber , amount from  payments where amount=(select max(amount) from payments);

#wasq to fetch productname , buyprice from products table , only fetch the product 
#whose buy price> avg buyprice of all the products
select productname , buyprice from products where buyprice>(select avg(buyprice) from products);


#wasq to fetch customername, customerno , check no , and amount of a customer 
#who paid amount <avg amount paid by all customer
select customernumber, customername , checknumber, amount from customers inner join payments 
using (customernumber) where amount <(select avg(amount) from payments);


#wasq to fetch customername , who have not placed any order
select customername from customers where customernumber not in (select distinct customernumber from orders);

#wasq to fetch poductname that have never been sold 
select productname from products where productcode not in (select distinct productcode from orderdetails);

#wasq to fetch employees emp name, who do not manage any customer
select employeenumber, concat(firstname,' ',lastname)as empfullname from employees 
where employeenumber not in (select salesrepemployeenumber from customers 
where salesrepemployeenumber is not null);

#wasq to fetch top 3 highest tov products of each productline
select * from
(select productline, productname , sum(quantityordered*priceeach)as tov , dense_rank()over 
(partition by productline order by sum(quantityordered*priceeach) desc) as d_rn 
from orderdetails inner join products using (productcode) group by 1, 2)as derived_1 
where d_rn<=3;

#wasq to fetch empname, totalsales , custom col --- employee_type 
#totalsales < 200k - worst performer 
#totalsales betweenn 200k and 500k - avg performer 
#total sales > 500k best performer


select employee_type ,count(employee_type)as empcount from 
(select * , case
when totalsales < 200000 then "worst performer" 
when totalsales between 200000 and 500000 then " avg performer " 
else "best performer" 
end as employee_type from 
(select concat(firstname," ",lastname)as empfullname , sum(quantityordered*priceeach)as totalsales
from employees inner join customers on(salesrepemployeenumber=employeenumber) inner join 
orders using(customernumber) inner join orderdetails using (ordernumber) 
group by 1 )as derived1 )as derived2 group by 1;


#wasq to fetch customername , and their total ordervalue on the basis of tov 
#create one custom col customer_type 
#cond are tov <10k " silver customer" , tov between 10k and 100k "gold cust"
#tov > 100k "platinum cust"

select customer_type, count(customer_type)as countofcust from 
(select *, case 
when tov <10000 then "silver customer" 
when tov between 10000 and 100000 then "gold customer"
else "platinum customer"
end as customer_type from 
(select customername , sum(quantityordered*priceeach) as tov from customers 
inner join orders using (customernumber ) inner join orderdetails 
using(ordernumber) group by 1 )as derived1)as derived2 group by 1;



select customer_type , count(customer_type)as custcount from 
(select* , case 
when ordercount = 1 then "one time"
when ordercount = 2 then "repeated"
when ordercount=3 then "frequent "
else "loyal"
end as customer_type from 
(select customername , count(ordernumber)as ordercount from customers inner join orders
using (customernumber) group by 1 )as derived1)as derived2 group by 1;



select * , case
when tov <1000000 then "least selling "
when tov between 1000000  
(select productline , sum(quantityordered*priceeach)as tov from products inner join orderdetails 
using (productcode) group by 1 )as derived1

















