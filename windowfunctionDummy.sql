# row_number()

# wasq to give sequential number to all the products?

select *,row_number() over() as s_no from products;

select row_number() over() as s_no,p.* from products p;

# wasq to give sequential to all the products of each productline?

select row_number() over(partition by productline) as r_no,
p.* from products p;

# wasq to give sequential to al the products of each productline
# by buyprice highest to lowest?

select row_number() over(partition by productline 
order by buyprice desc) as r_no,p.* from products p;

with cte as
(select row_number() over(partition by productline 
order by buyprice desc) as r_no,p.* from products p
)
select * from cte where r_no=1;


# wasq to fetch 2nd nd 3rd highest tov products of 
# each productline?
with cte as
(select productline,productname,sum(quantityordered*priceeach)as tov,
dense_rank() over(partition by productline 
order by sum(quantityordered*priceeach) desc) as d_rn
from products inner join orderdetails using(productcode)
group by productline,productname)
select * from cte where d_rn in (2,3);


# wasq to fetch 3rd least tov product of each productline of each orderyear?
with cte as
(select productline,productname,year(orderdate) as orderyear,
sum(quantityordered*priceeach) as tov,
dense_rank() over(partition by productline,year(orderdate) 
order by sum(quantityordered*priceeach) asc) as d_rn
from products inner join orderdetails using(productcode)
inner join orders using(ordernumber) group by 1,2,3)
select * from cte where d_rn=3;


# wasq to fetch top 2 highest tov customers of each country?

# wasq to fetch top 3 highest ordercount customers of each orderyear?

# wasq to fetch least amount paid customers of each country of each paymentyear?

# wasq to fetch 2nd and 3rd highest tov employee of each country of each orderyear?

# wasq to fetch 2nd and 3rd least totalquatityordered products 
# of each productline of each orderyear?

# wasq to get totalquantityordered contribution of each 
# products of each productline to the totalquantityordered of 
# that same productline?

