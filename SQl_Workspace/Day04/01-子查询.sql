---From子查询

--- 案例: 查询薪资大于等于3000的雇员名称、薪资、部门号
select ename, sal, deptno
from emp
where sal >= 3000;

-----使用from子查询 把查询的结果当做临时表继续查询上面操作
select ename, sal, deptno
from (select ename, sal, deptno from emp where sal >= 3000) t;


-- 需求: 每个部门平均薪水的等级
1 先查出每个部门的平均薪水
select deptno, avg(sal) as avgsal
from emp
group by deptno;

2 再在查出的临时表中关联其他表进行薪水等级排序
select *
from (select deptno, avg(sal) as avgsal
     from emp
     group by deptno) t
     join salgrade sg on t.avgsal between sg.losal and sg.hisal;


-- 需求：
1 select deptno from dept where dname = 'SALES';
2 select *
         from emp
         where deptno = (select deptno from dept where dname = 'SALES')


--多行1列
-- 需求1：查询销售部(SALES) 和 财务部(ACCOUNTING) 的雇员信息 
1 select deptno from dept where dname = 'SALES' or dname = 'ACCOUNTING';--用dname in ('','') 代替
步骤1中的等于号等价于in 因为销售部和财务部都是属于一列的内容 则显示部门号输出的是一列的内容

2 select * from emp where deptno in 
         (select deptno from dept where dname = 'SALES' or dname = 'ACCOUNTING');



---每个部门最高工资
select max(sal)
from emp
where deptno = 20;

select dname from dept d where e.deptno = d.deptno;

select e.ename, e.job, e.deptno, sal, (select max(sal) from emp where deptno = e.deptno) as MAXSAL,
        (select dname from dept d where e.deptno = d.deptno) as DEPT
from emp e
WHERE E.SAL=(select max(sal) from emp where deptno = e.deptno);


-------------exists查询

------- 需求1：查询存在雇员的部门，显示部门ID、部门名称、部门位置
select *
from dept d
where exists (select * from emp where deptno = d.deptno);

--找出所有在‘sales’部门工作的雇员
