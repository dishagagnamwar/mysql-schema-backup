CREATE TABLE sales1(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales1 (sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales1;

#wasq to fetch totalsales from sales1 table 
select sum(sale)as totalsales from sales1;

select *, sum(sale) over() as totalsales from sales1;

#wasq to fetch totalsales of each sales_employyee
select sales_employee,  sum(sale)as totalsales from sales1 group by sales_employee;

select*, sum(sale) over(partition by sales_employee)as ts from sales1;

#wasq to fetch totalsales of each fiscal year
select fiscal_year, sum(sale)as totalsales from sales1 group by fiscal_year;

with cte as
(select* , sum(sale) over(partition by fiscal_year)as ts from sales1)
select *, round((sale/ts)*100,2) as contribution from cte;


#wasq to fetch totalsales , maxsales, minsales, avgsales, and no of records in each fiscal year
select fiscal_year , sum(sale)as totalsales , max(sale) as maxsales, min(sale)as minsales,
 avg(sale)as avgsales, count(*) as count from sales1 
group by fiscal_year;

select *, sum(sale) over (partition by fiscal_year) as ts,
max(sale) over (partition by fiscal_year) as ts,
min(sale) over (partition by fiscal_year) as ts,
avg(sale) over (partition by fiscal_year) as ts,
count(sale) over (partition by fiscal_year) as ts,
sum(sale) over (partition by fiscal_year) as ts,













