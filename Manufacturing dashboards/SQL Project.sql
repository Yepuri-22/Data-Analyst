create database manufacturing;
use manufacturing;

-- imported data
select * from project;

-- 1) manufacturing Qty
select concat(format(sum(`manufactured qty`)/1000000,2),"M") as `Manufacture Qty` from project;

-- 2) Rejected Qty
select concat(format(sum(`rejected qty`)/1000,0),"K") as `Rejected Qty` from project;

-- 3) Processed Qty
select concat(format(sum(`processed Qty`)/1000000,0),"M") as "Processed Qty" from project;

-- 4) Wastage % 
select concat(format((sum(`rejected qty`)/sum(`processed qty`))*100,2),"%") as `Wastage %` from project;


-- 5) employee wise rejected qty
select `Machine / employee` as Employee,sum(`rejected qty`) as Rejected_qty from project 
group by `machine / employee` order by sum(`rejected qty`) desc;

-- 6) machine wise rejected Qty
select `operation name` as Machine_Name,sum(`rejected qty`) as Rejected_Qty from project
group by `operation name` order by  sum(`rejected qty`) desc;


-- 7) Production comparison trend 
select Production_date,Manufactured_Qty,
concat(format(((manufactured_qty-lag(manufactured_qty,1,0)over())/(lag(manufactured_qty,1,0)over()))*100,0),"%") as Trend
from (select date(`fiscal date`) as Production_date,concat(format(sum(`manufactured qty`)/1000000,2)," M") as Manufactured_Qty 
from project group by `fiscal date` order by `fiscal date`) as production;


-- 8) Manufacured Qty vs Rejected qty
select date(`fiscal date`) date,
    concat(format(SUM(`Manufactured Qty`)/1000000,2)," M") AS Total_Manufactured,
    concat(format(SUM(`Rejected Qty`)/1000,2)," K") AS Total_Rejected,
    concat(format((SUM(`Rejected Qty`) / SUM(`Manufactured Qty`)) * 100, 2), ' %') AS Rejection_Rate
from project
group by `fiscal date`
order by `fiscal date`;


-- 9) Department wise Manufactured Qty vs rejected qty
select `Department name`,concat(format(sum(`manufactured Qty`)/1000000,0)," M") as Manufactured_Qty,
concat(format(sum(`rejected qty`)/1000,0)," K") as Rejected_Qty 
from project group by `Department name`;


-- 10) Emp wise Rejected Qty
select `emp name`,sum(`rejected qty`) as Rejected_Qty from project 
group by `emp name` order by sum(`rejected qty`) desc;





