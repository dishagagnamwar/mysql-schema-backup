#wasq to fetch customernumber, chq no , amount of a customer who paid the max amount
select customernumber , checknumber , amount from payments where amount = (select max(amount) from payments);

#wasq to fetch customername , amount of the customer who paid amount more than the avg amount paid by all customer
select customername , amount from customers inner join payments using (customernumber) 
where amount >(select max(amount) from payments);

#wasq to fetch productname ,and a buyprice of a product whose buyprice is less than the avg buyprice of all product
select productname , buyprice from products where buyprice< (select avg(buyprice) from products);

#wasq to fetch customersname , who have placed any order 

#wasq to fetch customersname , who have placed not any order 


#wasq to fetch productname that have never been sold 


#wasq to fetch employees who have not managed any customer 



#wasq to fetch customercount of each category this category based on totalorder value 
#cond are if tov < 30000 (silver customer)
#30000 and 100000 (gold)
#>100000(platinum) , these category comes under the colname cust_type ( using subquery only)

select cust_type , count(cust_type) as custcount from
(select * , case 
when tov< 30000 then "silver customer"
when tov between 30000 and 100000 then "gold customer"
else "platinum customer"
end as cust_type from 
(select distinct customername  , sum(quantityordered*priceeach)as tov from customers inner join
orders using(customernumber) inner join orderdetails using(ordernumber) group by 
1)as derived1) as derived2 group by 1;



#wasq to fetch bottom two least order count customer of each country of each order year (using subquery only)
