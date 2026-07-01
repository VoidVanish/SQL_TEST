--实战:求部门中薪水大于1200的员工的平均工资，查平均资大于2500的部门号，按部门号(平均薪资)升序排序
select deptno,avg(sal) as avgsal
from emp
where sal>1200
group by deptno
having avg(sal)>2500
--order by deptno;  --(部门号)
order by avgsal; --（平均薪资）

select max(sal)
from emp
group by deptno;
