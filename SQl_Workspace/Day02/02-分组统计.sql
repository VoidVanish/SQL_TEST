--group by 广们group by 列:对结果集所有行按结论:分组后，select后面的内容
--注意:分组后，数据由一条一条的
--值相同的归为一组，以便统计操作的内容，要么是统计操作 变成一组一组的(组为单位)
-- 案例：统计每个部门的人数

select deptno,count(1)
from emp
group by deptno;
--分组统计逻辑与排序逻辑一致且冲突所以两者不能共用且需分别存储
--------------------------
 

--需求: 求部门中薪水大于1200的员工的平均工资大于2500的部门号
select deptno,avg(sal)
from emp
where sal>1200
group by deptno
having avg(avg)>2500;
